# 🚖 BuMo – Bulan Moonride Motorcycle Ride App

**BuMo** is a Flutter-based mobile application that replicates the core functionality of ride-hailing platforms like Angkas. It provides a seamless user experience for both **riders** and **drivers**, enabling real-time booking, navigation, and communication.

---

## 🧩 Features

### 👥 User Roles
- **Rider**: Request rides, track driver location, view ride history
- **Driver**: Accept ride requests, navigate to pickup/drop-off points, manage availability

### 🗺 Real-Time Location & Navigation
- Google Maps integration
- Live location tracking
- Route rendering and markers

### 💬 Messaging
- Chat system between rider and driver
- Firebase-powered inbox and conversation threads

### 🔐 Authentication
- Secure registration and login for both roles
- Email verification and password recovery

---

## 🛠 Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Maps & Location**: Google Maps API, Geolocator
- **State Management**: Riverpod
- **Realtime Messaging**: Firebase Cloud Firestore

---

## 🚀 Getting Started

### ✅ Prerequisites
- Flutter SDK
- Firebase Project (iOS + Android setup)
- Google Maps API Key

### 📥 Installation

```bash
git clone https://github.com/crisvin03/BuMo.git
cd BuMo
flutter pub get
