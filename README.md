# IPPort

![Author](https://img.shields.io/badge/Author-POMBO-blue)
![Year](https://img.shields.io/badge/Year-2025-green)
![Version](https://img.shields.io/badge/Version-1.0-orange)

**IPPort** is a lightweight batch utility script (Batch/CMD) designed to automate essential point-to-point connectivity tests between the local machine and a target host (IP or URL). It combines the efficiency of the native Batch ecosystem with dynamic PowerShell graphical interfaces, making rapid network troubleshooting agile and accessible for technicians and administrators.

---

## 🚀 Features

- **Guided Graphical Interface:** Utilizes graphical input boxes (`InputBox`) and message boxes (`MessageBox`) via PowerShell, eliminating the need for the operator to type parameters directly into the command line.
- **Dynamic Internationalization (Bilingual):** Automatically detects the default Operating System language (by querying the `LocaleName` key in the Windows Registry) and dynamically adapts the entire interface and messages to either **Portuguese (PT)** or **English (EN)**.
- **Preventive Host Filtering:** Features a security validation that blocks script execution if the operator enters potentially malicious, spam, or incompatible domains (such as `.onion` and `.xyz` extensions).
- **Dynamic User-Agent:** Generates a unique random identifier (`IPPort_XXXX`) on every execution. This signature is injected into the `curl` HTTP requests, mitigating automated blocks by WAFs (Web Application Firewalls) during server health checks.
- **IPv6 Support:** Structured to accept IPv6 addresses, guiding the user to enclose them in brackets (e.g., `[XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX]`).

---

## 🔍 Execution Sequence (Diagnostic Pipeline)

The script performs a direct sequential sweep to isolate network failures clearly:
1. **TCP Connectivity Validation (`Test-NetConnection`):** Tests connection to a specific port (if provided) or runs a default port diagnostic, retrieving technical details about the connection interface.
2. **Simple Ping (`ping`):** Validates basic ICMP echo responses and route latency.
3. **DNS Resolution (`nslookup`):** Queries default name resolution to verify if the domain correctly resolves to a valid IP address.
4. **Canonical Address Lookup (`nslookup -type=CNAME`):** Identifies the existence of aliases or redirects within the target's DNS infrastructure.
5. **HTTP Header Inspection (`curl`):** Executes an HTTP `HEAD` (`-I`) request with a maximum timeout of 120 seconds, applying the dynamic *User-Agent* to analyze HTTP return codes (e.g., 200 OK, 403 Forbidden, 500 Error).
6. **Route Tracing (`tracert`):** Lists all hops the packet traverses until reaching the destination, ideal for identifying bottlenecks or routing loops.

---

## 📋 Prerequisites

- **Operating System:** Windows 10 or Windows 11.
- **Native Dependencies:** The script utilizes native Windows components (`powershell.exe`, `curl.exe`, standard networking tools). No third-party installations are required.
- **Privileges:** Can be executed with standard user privileges.

---

## 🛠️ How to Use

1. Copy the original `IPPort` script code.
2. Open **Notepad** or your preferred text editor.
3. Paste the code and save the file with a **`.bat`** or **`.cmd`** extension (Example: `IPPort.bat`).
4. **Encoding Tip:** Ensure you save the file with `UTF-8` encoding to guarantee that special characters and accents render perfectly within the terminal's code page (`chcp 65001`).
5. Double-click the generated file to start the tests.

---

## 👤 Credits and Signature

- **Developer:** POMBO `\Õ/`
- **Signature / Key:** `@EWEP - 2025`
- **Purpose:** Agile, lean, and direct point-to-point network diagnostics.
