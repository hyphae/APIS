import requests
import json
import time

print("Waiting for services to start...")
time.sleep(10) # Simple wait, or use retry logic

# 1. Energy Balance Check (Get Hardware Logs)
try:
    print("\n--- Testing Energy Balance Check API ---")
    url = "http://localhost:43900/get/log"
    print(f"GET {url}")
    response = requests.get(url, timeout=5)
    print(f"Status: {response.status_code}")
    if response.status_code == 200:
        data = response.json()
        print("Success! Received hardware telemetry.")
        # Check first key (usually 'apis' or specific unit ID)
        print(f"Keys: {list(data.keys())[:3]}...")
    else:
        print("Failed to get logs.")
except Exception as e:
    print(f"Error: {e}")

# 2. Power Allocation (Deal Generation)
try:
    print("\n--- Testing Power Allocation API ---")
    url = "http://localhost:9999/deal"
    
    # Mock OpenPAYGO Deal Payload (Example shape based on code)
    payload = {
        "dealId": "test-deal-001",
        "requestUnitId": "unit1",
        "acceptUnitId": "unit2",
        "amountWh": 100,
        "type": "charge"
    }
    
    # The API expects form-data with a 'json' field containing the stringified JSON
    files = {
        'json': (None, json.dumps(payload))
    }
    
    print(f"POST {url} with payload: {payload}")
    response = requests.post(url, files=files, timeout=5)
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text}")
    
    if response.status_code == 200:
        print("Success! Deal request submitted.")
    else:
        print("Deal submission failed.")

except Exception as e:
    print(f"Error: {e}")
