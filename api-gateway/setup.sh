#!/bin/bash

# APIS API Gateway Setup Script
# Issue #43: Security Hardening and Performance Optimization

set -e

echo "🔧 Setting up APIS API Gateway..."

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p ssl cache logs monitoring/grafana-dashboards modsec

# Generate self-signed SSL certificate for development
echo "🔐 Generating SSL certificates..."
if [ ! -f ssl/apis.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout ssl/apis.key \
        -out ssl/apis.crt \
        -subj "/C=US/ST=State/L=City/O=APIS/CN=apis.local"
    
    # Generate Diffie-Hellman parameters
    openssl dhparam -out ssl/dhparam.pem 2048
    
    echo "✅ Self-signed certificates generated"
else
    echo "✅ SSL certificates already exist"
fi

# Download OWASP ModSecurity Core Rule Set
echo "🛡️  Setting up ModSecurity WAF..."
if [ ! -d modsec/owasp-crs ]; then
    git clone https://github.com/coreruleset/coreruleset.git modsec/owasp-crs
    cd modsec/owasp-crs
    mv crs-setup.conf.example crs-setup.conf
    cd ../..
    echo "✅ OWASP CRS installed"
else
    echo "✅ OWASP CRS already installed"
fi

# Create ModSecurity configuration
if [ ! -f modsec/modsecurity.conf ]; then
    cat > modsec/modsecurity.conf <<'EOF'
SecRuleEngine On
SecRequestBodyAccess On
SecRequestBodyLimit 13107200
SecRequestBodyNoFilesLimit 131072
SecRequestBodyLimitAction Reject
SecPcreMatchLimit 100000
SecPcreMatchLimitRecursion 100000
SecResponseBodyAccess On
SecResponseBodyMimeType text/plain text/html text/xml application/json
SecResponseBodyLimit 524288
SecResponseBodyLimitAction ProcessPartial
SecTmpDir /tmp/
SecDataDir /tmp/
SecAuditEngine RelevantOnly
SecAuditLogRelevantStatus "^(?:5|4(?!04))"
SecAuditLogParts ABIJDEFHZ
SecAuditLogType Serial
SecAuditLog /var/log/nginx/modsec_audit.log
SecArgumentSeparator &
SecCookieFormat 0
SecUnicodeMapFile unicode.mapping 20127
SecStatusEngine On
EOF
    echo "✅ ModSecurity configuration created"
fi

# Create Prometheus configuration
echo "📊 Setting up monitoring..."
cat > monitoring/prometheus.yml <<'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'nginx'
    static_configs:
      - targets: ['api-gateway:443']
    metrics_path: '/metrics'
    scheme: https
    tls_config:
      insecure_skip_verify: true

  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
EOF

# Create Grafana datasource configuration
cat > monitoring/grafana-datasources.yml <<'EOF'
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
    editable: true
EOF

# Create basic Grafana dashboard
cat > monitoring/grafana-dashboards/apis-gateway.json <<'EOF'
{
  "dashboard": {
    "title": "APIS Gateway Metrics",
    "panels": [
      {
        "title": "Request Rate",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(nginx_http_requests_total[5m])"
          }
        ]
      }
    ]
  }
}
EOF

echo "✅ Monitoring configured"

# Set proper permissions
echo "🔒 Setting permissions..."
chmod 600 ssl/apis.key
chmod 644 ssl/apis.crt
chmod 755 cache logs

echo ""
echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Review nginx.conf and adjust upstream servers if needed"
echo "2. For production, replace self-signed certs with Let's Encrypt:"
echo "   docker-compose run --rm certbot certonly --webroot -w /var/www/certbot -d your-domain.com"
echo "3. Start the gateway: docker-compose up -d"
echo "4. Access services:"
echo "   - API Gateway: https://localhost"
echo "   - Prometheus: http://localhost:9090"
echo "   - Grafana: http://localhost:3000 (admin/admin)"
echo ""
