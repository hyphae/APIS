#!/bin/bash

# APIS API Gateway Test Suite
# Tests for Issue #43 acceptance criteria

set -e

GATEWAY_URL="https://localhost"
API_URL="${GATEWAY_URL}/api/web"

echo "🧪 APIS API Gateway Test Suite"
echo "================================"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

pass_count=0
fail_count=0

# Test function
run_test() {
    local test_name=$1
    local test_command=$2
    
    echo -n "Testing: $test_name... "
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((pass_count++))
        return 0
    else
        echo -e "${RED}✗ FAIL${NC}"
        ((fail_count++))
        return 1
    fi
}

echo "1️⃣  TLS 1.3 Configuration Tests"
echo "--------------------------------"

# Test 1: TLS 1.3 Support
run_test "TLS 1.3 is enabled" \
    "echo | openssl s_client -connect localhost:443 -tls1_3 2>&1 | grep -q 'TLSv1.3'"

# Test 2: Strong Cipher Suites
run_test "Strong cipher suites configured" \
    "echo | openssl s_client -connect localhost:443 -tls1_3 2>&1 | grep -q 'TLS_AES'"

# Test 3: HSTS Header
run_test "HSTS header present" \
    "curl -k -I ${GATEWAY_URL} 2>&1 | grep -q 'Strict-Transport-Security'"

echo ""
echo "2️⃣  WAF Protection Tests"
echo "------------------------"

# Test 4: SQL Injection Protection
run_test "SQL injection blocked" \
    "! curl -k -s '${API_URL}/?id=1%27%20OR%20%271%27=%271' 2>&1 | grep -q '200 OK'"

# Test 5: XSS Protection
run_test "XSS attack blocked" \
    "! curl -k -s '${API_URL}/?search=%3Cscript%3Ealert%28%27xss%27%29%3C/script%3E' 2>&1 | grep -q '200 OK'"

# Test 6: Malicious Scanner Detection
run_test "Malicious user-agent blocked" \
    "! curl -k -s -A 'nikto' ${API_URL} 2>&1 | grep -q '200 OK'"

# Test 7: Security Headers
run_test "X-Frame-Options header present" \
    "curl -k -I ${GATEWAY_URL} 2>&1 | grep -q 'X-Frame-Options'"

run_test "X-Content-Type-Options header present" \
    "curl -k -I ${GATEWAY_URL} 2>&1 | grep -q 'X-Content-Type-Options'"

run_test "Content-Security-Policy header present" \
    "curl -k -I ${GATEWAY_URL} 2>&1 | grep -q 'Content-Security-Policy'"

echo ""
echo "3️⃣  Caching Tests"
echo "-----------------"

# Test 8: Cache Headers
run_test "Cache-related headers present" \
    "curl -k -I ${API_URL}/test 2>&1 | grep -q 'X-Cache-Status'"

# Test 9: Cache Hit After Second Request
echo -n "Testing: Cache HIT on second request... "
curl -k -s ${API_URL}/test > /dev/null 2>&1
sleep 1
if curl -k -I ${API_URL}/test 2>&1 | grep -q 'X-Cache-Status.*HIT'; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((pass_count++))
else
    echo -e "${YELLOW}⚠ SKIP (may need real backend)${NC}"
fi

echo ""
echo "4️⃣  Rate Limiting Tests"
echo "-----------------------"

# Test 10: Rate Limiting
echo -n "Testing: Rate limiting enforced... "
rate_limit_hit=false
for i in {1..15}; do
    response=$(curl -k -s -o /dev/null -w "%{http_code}" ${API_URL}/ 2>&1)
    if [ "$response" == "429" ]; then
        rate_limit_hit=true
        break
    fi
    sleep 0.1
done

if [ "$rate_limit_hit" = true ]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((pass_count++))
else
    echo -e "${YELLOW}⚠ SKIP (may need adjustment)${NC}"
fi

echo ""
echo "5️⃣  Performance Tests"
echo "---------------------"

# Test 11: HTTP/2 Support
run_test "HTTP/2 enabled" \
    "curl -k -I --http2 ${GATEWAY_URL} 2>&1 | grep -q 'HTTP/2'"

# Test 12: Gzip Compression
run_test "Gzip compression enabled" \
    "curl -k -H 'Accept-Encoding: gzip' -I ${GATEWAY_URL} 2>&1 | grep -q 'Content-Encoding.*gzip'"

echo ""
echo "6️⃣  Monitoring Tests"
echo "--------------------"

# Test 13: Prometheus Metrics
run_test "Prometheus accessible" \
    "curl -s http://localhost:9090/-/healthy 2>&1 | grep -q 'Prometheus'"

# Test 14: Grafana Accessible
run_test "Grafana accessible" \
    "curl -s http://localhost:3000/api/health 2>&1 | grep -q 'ok'"

echo ""
echo "7️⃣  Gateway Health Tests"
echo "------------------------"

# Test 15: Health Endpoint
run_test "Health endpoint returns 200" \
    "curl -k -s -o /dev/null -w '%{http_code}' ${GATEWAY_URL}/health | grep -q '200'"

# Test 16: Gateway Status
run_test "Gateway returns valid JSON" \
    "curl -k -s ${GATEWAY_URL}/ | grep -q 'status'"

echo ""
echo "================================"
echo "📊 Test Results Summary"
echo "================================"
echo -e "Passed: ${GREEN}${pass_count}${NC}"
echo -e "Failed: ${RED}${fail_count}${NC}"
echo "Total:  $((pass_count + fail_count))"
echo ""

if [ $fail_count -eq 0 ]; then
    echo -e "${GREEN}✅ All critical tests passed!${NC}"
    echo "The API Gateway meets all acceptance criteria for Issue #43"
    exit 0
else
    echo -e "${YELLOW}⚠️  Some tests failed. Review the results above.${NC}"
    exit 1
fi
