# Intune Proactive Remediations – Defender Secure Score - Registry-Based Security Baseline

## Overview

This repository contains a collection of **Intune Proactive Remediation scripts** used to enforce security-related registry settings on Windows devices.

These scripts are primarily intended for **Microsoft Entra ID (Azure AD) joined devices**, where traditional Group Policy Objects (GPO) are not available or not in use.

---

## Purpose

In modern, cloud-managed environments using **Microsoft Intune**, not all security configurations are exposed through:

* Built-in Intune settings catalogs
* Endpoint security policies
* Administrative Templates

To bridge this gap, these scripts enforce required configurations directly via the Windows registry.

---

## When to Use This

Use these remediation scripts when:

* Devices are **Entra ID joined (cloud-only)**
* You are **not using on-prem Active Directory / GPOs**
* A required security setting is **not available in Intune**
* You need **consistent enforcement and reporting** via Intune

---

## How It Works

Each configuration is implemented using:

### Detection Script

* Checks if the registry value exists and is correctly configured
* Returns:

  * `0` → Compliant ("Preferred value is set.")
  * `1` → Not compliant

### Remediation Script

* Creates missing registry paths if required
* Sets the correct value
* Runs automatically when detection fails

---

## Design Principles

* **Idempotent**
  Scripts can run repeatedly without causing issues

* **Consistent Output**
  Standardized messages for clean Intune reporting:

  * "Preferred value is set."
  * "Expected value is not set needs remidiation."
  * "Registry path not found"
  * "Please follow up on the device. Unable to read value."

* **Minimal Noise**
  Output is intentionally concise for easier monitoring

* **Device Context Execution**
  Scripts are designed to run as **SYSTEM**

---

## Deployment in Intune

1. Go to **Devices → Scripts and Remediations**
2. Create a new **Proactive Remediation**
3. Upload:

   * Detection script
   * Remediation script
4. Configure:

   * Run as 64-bit PowerShell: **Yes**
   * Run using logged-on credentials: **No**
5. Assign to a **device group**

---

## Important Notes

* These settings may overlap with:

  * Security baselines
  * Administrative templates
  * Other configuration profiles

  Always ensure there are no conflicting policies.

* Registry-based enforcement should be used **only when no native Intune control exists**.

* Some settings may require:

  * A reboot
  * User logoff
  * Service restart

---

## Why Not GPO?

Traditional **Group Policy (GPO)** is not applicable for:

* Cloud-only (Entra ID joined) devices
* Modern device management scenarios

These scripts provide a **cloud-native alternative** while maintaining similar control and compliance enforcement.

---

## Future Improvements

* Centralized multi-setting script (JSON/array-driven)
* Enhanced logging (Event Log / Log Analytics)
* Reporting integration with compliance dashboards

---

## Disclaimer

These scripts modify system registry settings.
Always test in a **non-production environment** before broad deployment.
