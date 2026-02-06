FROM python:3.9-slim
WORKDIR /app
COPY apis-emulator/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY apis-emulator/ .
# Fix line endings if cloned on Windows
RUN apt-get update && apt-get install -y dos2unix && dos2unix *.py *.sh
CMD ["python3", "startEmul.py", "4"]
