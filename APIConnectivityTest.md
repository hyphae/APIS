# API Connectivity Test Guide

## **Overview**
Each mentee must validate the connectivity of their local development environment by making a test API request and logging the response. This ensures proper integration of OpenPAYGO Token and LF Hyphae APIs.

---

## **1. Choose an API Testing Tool**
To send a test API request, use one of the following tools:
- **Postman** (Recommended for manual testing)
- **cURL** (Command-line tool)
- **REST Client** (VS Code extension)
- **Python’s `requests` library** (For scripting API requests)

---

## **2. Identify API Endpoints**
- **OpenPAYGO Token API:**
  - Endpoint: `GET /status`
  - Purpose: Checks if the API is running.
- **LF Hyphae API:**
  - Endpoint: `GET /healthcheck`
  - Purpose: Verifies connectivity.

These endpoints return a JSON response confirming API accessibility.

---

## **3. Authenticate (If Required)**
Some APIs require authentication via:
- API keys
- OAuth tokens
- Bearer tokens

Check API documentation for the required authentication method.

---

## **4. Sending a Test API Request**

### **Using Postman:**
1. Open Postman and create a new request.
2. Set the request type to `GET`.
3. Enter the API URL, e.g., `http://localhost:5000/status`.
4. Add authentication under the "Authorization" tab (if needed).
5. Click "Send" and check the response.

### **Using cURL:**
```sh
curl -X GET "http://localhost:5000/status" -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

### **Using Python (`requests` library):**
```python
import requests

url = "http://localhost:5000/status"
headers = {"Authorization": "Bearer YOUR_ACCESS_TOKEN"}

response = requests.get(url, headers=headers)

# Log the response
print("Status Code:", response.status_code)
print("Response Body:", response.json())
```

---

## **5. Log the API Response**
Record the following details:
- **Status Code** (e.g., `200 OK` means success, `401` means unauthorized).
- **Response Body** (JSON data with API status).
- **Error Messages** (if any).

### **Example Response:**
#### **OpenPAYGO Token API:**
```json
{
  "status": "success",
  "message": "API is running"
}
```
#### **LF Hyphae API:**
```json
{
  "status": "healthy",
  "database": "connected"
}
```

---

## **6. Troubleshooting**
If the API request fails:
- Ensure the API service is running (`docker ps` if using Docker).
- Verify API credentials and access permissions.
- Check for firewall or network restrictions.

---

## **7. Document the Results**
Maintain a log file (`api_test.log`) to store responses:
```sh
echo "Status Code: 200, Response: API is running" >> api_test.log
```
Or in Python:
```python
with open("api_test.log", "a") as log_file:
    log_file.write(f"Status Code: {response.status_code}, Response: {response.json()}\n")
```

---

## **Conclusion**
This process ensures that OpenPAYGO Token and LF Hyphae APIs are accessible and ready for integration. If the response is correct, the development environment setup is successful.

