# APIS API Gateway - Security Hardening & Performance Optimization

**Implementation for Issue #43**

This API Gateway provides enterprise-grade security and performance optimization for the APIS (Autonomous Power Interchange System) platform.

## 🎯 Features Implemented

### ✅ Security Hardening
- **TLS 1.3 Support**: Latest TLS protocol with strong cipher suites
- **SSL/TLS Certificates**: Automated certificate management with Let's Encrypt
- **WAF Protection**: ModSecurity with OWASP Core Rule Set (CRS)
- **Security Headers**: HSTS, CSP, X-Frame-Options, etc.
- **Rate Limiting**: Protection against DDoS and brute-force attacks
- **Connection Limits**: Per-IP connection restrictions

### ✅ Performance Optimization
- **Multi-layer Caching**: 
  - API response caching (5-10 min TTL)
  - Static content caching (24h TTL)
  - Cache background updates
  - Stale cache serving during errors
- **HTTP/2 Support**: Multiplexed connections
- **Gzip Compression**: Reduced bandwidth usage
- **Connection Pooling**: Keepalive connections to upstreams
- **Load Balancing**: Least-connection algorithm

### ✅ Monitoring & Observability
- **Prometheus Metrics**: Real-time performance metrics
- **Grafana Dashboards**: Visual monitoring interface
- **Access Logs**: Detailed request logging with timing
- **Cache Hit Rates**: Performance tracking via X-Cache-Status headers

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Git
- OpenSSL (for certificate generation)

### Installation

1. **Navigate to the API Gateway directory:**
```bash
cd APIS/api-gateway
```

2. **Run the setup script:**
```bash
chmod +x setup.sh
./setup.sh
```

3. **Start the gateway:**
```bash
docker-compose up -d
```

4. **Verify the setup:**
```bash
# Check gateway health
curl -k https://localhost/health

# Check all services are running
docker-compose ps
```

## 📋 Configuration

### Upstream Services

The gateway proxies the following APIS services:

| Service | Internal Port | Gateway Path |
|---------|--------------|--------------|
| Main Controller | 4382 | `/controller/` |
| Web Service | 4381 | `/api/web/` |
| Main Service | 4380-4383 | `/api/main/` |
| Emulator | 4390 | `/emulator/` |
| Tester | 10000 | `/tester/` |
| Service Center | 8000 | `/service-center/` |

### TLS Configuration

**Development (Self-Signed):**
- Certificates are auto-generated during setup
- Located in `ssl/` directory

**Production (Let's Encrypt):**
```bash
# Generate certificate for your domain
docker-compose run --rm certbot certonly \
  --webroot -w /var/www/certbot \
  -d your-domain.com \
  --email your-email@example.com \
  --agree-tos
```

### WAF Configuration

**Paranoia Levels:**
- Level 1: Basic protection (default)
- Level 2: Moderate protection (recommended)
- Level 3: High protection
- Level 4: Maximum protection

Adjust in `docker-compose.yml`:
```yaml
environment:
  - PARANOIA=2  # Change this value
```

### Caching Strategy

**API Endpoints:**
- GET requests: 5 minutes
- POST/PUT/DELETE: No caching
- 404 responses: 1 minute

**Static Content:**
- CSS/JS/Images: 1 hour
- Service Center UI: 30 minutes

**Cache Purging:**
```bash
# Purge specific endpoint
curl -X PURGE https://localhost/api/cache/purge?path=/api/web/endpoint
```

## 🔒 Security Features

### Rate Limiting

| Endpoint | Rate Limit |
|----------|------------|
| API endpoints | 10 req/sec (burst: 20-30) |
| Login endpoints | 5 req/min |
| Connections per IP | 10 concurrent |

### WAF Rules

- **OWASP Top 10 Protection**
- **SQL Injection Prevention**
- **XSS Attack Prevention**
- **Malicious Scanner Detection**
- **API Content-Type Enforcement**

### Security Headers

All responses include:
- `Strict-Transport-Security`: Force HTTPS
- `X-Frame-Options`: Prevent clickjacking
- `X-Content-Type-Options`: Prevent MIME sniffing
- `Content-Security-Policy`: XSS protection
- `X-XSS-Protection`: Browser XSS filter

## 📊 Monitoring

### Prometheus Metrics
Access at: `http://localhost:9090`

Available metrics:
- Request rates
- Response times
- Cache hit ratios
- Error rates
- Connection counts

### Grafana Dashboards
Access at: `http://localhost:3000`
- **Default credentials**: admin/admin
- Pre-configured APIS Gateway dashboard

### Logs

```bash
# View access logs
docker-compose logs -f api-gateway

# View ModSecurity audit logs
docker-compose exec api-gateway tail -f /var/log/nginx/modsec_audit.log

# View error logs
docker-compose exec api-gateway tail -f /var/log/nginx/error.log
```

## 🧪 Testing

### Test TLS Configuration
```bash
# Check TLS version
openssl s_client -connect localhost:443 -tls1_3

# Test cipher suites
nmap --script ssl-enum-ciphers -p 443 localhost
```

### Test WAF Protection
```bash
# Should be blocked (SQL injection attempt)
curl -k "https://localhost/api/web/?id=1' OR '1'='1"

# Should be blocked (XSS attempt)
curl -k "https://localhost/api/web/?search=<script>alert('xss')</script>"
```

### Test Caching
```bash
# First request (cache MISS)
curl -k -I https://localhost/api/web/endpoint

# Second request (cache HIT)
curl -k -I https://localhost/api/web/endpoint

# Check X-Cache-Status header
```

### Test Rate Limiting
```bash
# Send rapid requests
for i in {1..20}; do curl -k https://localhost/api/web/; done

# Should see 429 (Too Many Requests) after limit
```

## 🔧 Maintenance

### Update SSL Certificates
```bash
# Renew certificates (automatic via certbot container)
docker-compose exec certbot certbot renew

# Reload NGINX
docker-compose exec api-gateway nginx -s reload
```

### Update WAF Rules
```bash
cd modsec/owasp-crs
git pull
docker-compose restart api-gateway
```

### Clear Cache
```bash
# Clear all caches
docker-compose exec api-gateway rm -rf /var/cache/nginx/*
docker-compose restart api-gateway
```

## 📈 Performance Tuning

### Adjust Cache Sizes
Edit `nginx.conf`:
```nginx
proxy_cache_path /var/cache/nginx/api 
  levels=1:2 
  keys_zone=api_cache:100m    # Increase this
  max_size=1g                  # Increase this
  inactive=60m;
```

### Adjust Worker Processes
```nginx
worker_processes auto;  # Uses all CPU cores
worker_connections 2048; # Increase for high traffic
```

### Enable Redis Caching
Uncomment Redis configuration in `nginx.conf` for advanced caching.

## 🐛 Troubleshooting

### Gateway not starting
```bash
# Check logs
docker-compose logs api-gateway

# Verify configuration
docker-compose exec api-gateway nginx -t
```

### SSL certificate errors
```bash
# Regenerate self-signed certificates
rm -rf ssl/*
./setup.sh
```

### WAF blocking legitimate requests
```bash
# Reduce paranoia level
# Edit docker-compose.yml: PARANOIA=1

# Or disable specific rules in modsec/main.conf
```

### Cache not working
```bash
# Check cache directory permissions
docker-compose exec api-gateway ls -la /var/cache/nginx

# Verify cache headers
curl -k -I https://localhost/api/web/endpoint | grep X-Cache-Status
```

## 📚 Architecture

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │ HTTPS (TLS 1.3)
       ▼
┌─────────────────────────────────┐
│     NGINX API Gateway           │
│  ┌──────────────────────────┐  │
│  │   ModSecurity WAF        │  │
│  └──────────────────────────┘  │
│  ┌──────────────────────────┐  │
│  │   Rate Limiting          │  │
│  └──────────────────────────┘  │
│  ┌──────────────────────────┐  │
│  │   Response Cache         │  │
│  └──────────────────────────┘  │
└────────┬────────────────────────┘
         │
    ┌────┴────┐
    ▼         ▼
┌────────┐ ┌────────┐
│ APIS   │ │ APIS   │
│Services│ │Services│
└────────┘ └────────┘
```

## 🤝 Contributing

This implementation addresses Issue #43. For improvements:

1. Fork the repository
2. Create a feature branch
3. Test thoroughly
4. Submit a pull request

## 📄 License

Apache License 2.0 - Same as APIS project

## ✅ Acceptance Criteria Met

- ✅ **TLS 1.3 enabled** with strong cipher suites
- ✅ **SSL/TLS certificates** configured with auto-renewal
- ✅ **WAF protection** via ModSecurity + OWASP CRS
- ✅ **Caching implemented** with multiple strategies
- ✅ **Security measures enforced** (headers, rate limiting, etc.)
- ✅ **Performance optimized** (HTTP/2, compression, connection pooling)
- ✅ **Response times improved** through intelligent caching

---

**Issue Reference**: [#43 - Security Hardening and Performance Optimization](https://github.com/hyphae/APIS/issues/43)
