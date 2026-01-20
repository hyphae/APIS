## 💻 Native Host Installation Guide
![image 2](https://github.com/user-attachments/assets/66de9429-c395-4b02-a015-b4a11e455b1f)
### **1. System Requirements**

The project has been validated across multiple environments. Ensure your host meets these specifications to avoid build failures.

* **Ubuntu:** 18.04, 20.04 ✅
* **CentOS:** 7, 8 ✅
* **macOS:** Catalina, Big Sur ✅

> [!IMPORTANT]
> **Virtual environments are not currently supported.** Native installation must be performed directly on the host OS.

---

### **2. Prerequisites**

Install the core toolchain before attempting the build.

**Debian/Ubuntu Systems:**

```bash
sudo apt update
sudo apt install git make maven groovy python3-venv python3-pip

```

**Global Dependencies:**

* **JDK:** Latest version required for Maven builds.
* **Python:** 3.6.9+ required for the emulator.
* **SQLite:** 3.8.3+ (Critical for CentOS 7 users).

---

### **3. Installation Steps**

1. **Clone the Repository:**
```bash
git clone https://github.com/hyphae/APIS.git
cd APIS

```


2. **Build All Components:**
The `Makefile` handles the compilation of all internal services. This process typically takes **5-10 minutes**.
```bash
make build

```


3. **Start the System:**
```bash
make run

```


4. **Verify Deployment:**
* **Dashboard:** Navigate to `http://0.0.0.0:4382/`
* **Status Check:** All components in the APIS control panel should display a **"Running"** status.



---

### **4. Troubleshooting**

* **Command not found:** Verify that all items in the **Prerequisites** section are in your `$PATH`.
* **Build/Run Failures:** Environmental variables may not have refreshed; open a new terminal session and retry.
* **Port Conflicts:** Ensure ports `4382` and `4390` are not occupied by other web services.
* **Permission Denied:** Ensure your user has write access to the `APIS` directory or use appropriate privileges for system-level dependency installation.
