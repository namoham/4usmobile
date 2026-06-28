# 4US Mobile App — Case Study

&gt; Production cross-platform mobile application built with Flutter and Dart.
&gt; Developed at 4US Consulting Company (Morocco/Sudan) | Oct 2019 – Feb 2023
&gt; Source code is proprietary and not available for public sharing.
&gt; This repository documents the architecture, features, and technical decisions.

---

## 📱 Overview

The 4US mobile app is a cooperative financial management platform serving cooperative organizations across North Africa. I served as the **Senior Software Engineer** leading mobile development from architecture to deployment.

---

## 🏗 Architecture

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Provider (ChangeNotifier)
- **Architecture Pattern:** Layered architecture with DAO pattern
- **Backend:** RESTful APIs with configurable base URLs
- **Database:** SQLite (local persistence)
- **Local Storage:** SharedPreferences (user preferences, switch states)
- **Authentication:** Biometric (fingerprint) + traditional login
- **Networking:** HTTP
- **Push Notifications:** Firebase Cloud Messaging
- **Maps & Location:** Google Maps, geocoding, geolocation
- **Image Handling:** image_picker, flutter_svg
- **File Upload:** file_picker
- **Data Visualization:** fl_chart
- **QR Scanning:** qr_code_scanner
- **Offline Support:** flutter_offline
- **Multi-language:** English, Arabic, French
- **Theming:** Dynamic dark/light mode

---

## ✨ Key Features

1. **Multi-Institution Support** — Dynamic institution selection with configurable branding, parameters, and backend endpoints
2. **Offline-First Architecture** — Full app functionality without network connectivity using SQLite and SharedPreferences
3. **Biometric Authentication** — Secure fingerprint login alongside traditional authentication
4. **Geolocation & Mapping** — Location-based cooperative tracking and beneficiary management
5. **QR Code Scanning** — Quick beneficiary identification and transaction processing
6. **Data Visualization** — Investment tracking, profit analysis, and contribution reporting dashboards
7. **Multi-Language Support** — English, Arabic, and French localization
8. **Dynamic Theming** — Dark and light mode with user preference persistence

---

## 🛠 Technical Highlights

- Implemented Provider state management with ChangeNotifier pattern for reactive UI updates and dynamic theming
- Designed offline-first architecture enabling full functionality in rural areas with limited connectivity
- Integrated Google Maps, geocoding, and geolocation services for location-based tracking
- Built configurable multi-tenant system allowing independent cooperatives to self-manage branding and backend integration
- Developed biometric authentication using local_auth for secure access
- Created data visualization dashboards using fl_chart for financial reporting
- Added QR code scanning for rapid beneficiary identification
- Managed image capture and file upload workflows for document submission

---

## 📝 Lessons Learned

- Building for offline-first is critical in markets with unreliable connectivity
- Multi-tenant architecture requires careful separation of data and configuration
- Biometric authentication improves user trust and security in financial applications
- Localization requires more than translation — it requires cultural adaptation of UI and workflows

---

## 🔗 Connect

- [LinkedIn](https://linkedin.com/in/namarig-mohammed-7a03b9180)
- Email: namarigwahbi@gmail.com
