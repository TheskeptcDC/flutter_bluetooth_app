# Flutter Bluetooth App

This Flutter application enables real-time communication between devices via Bluetooth. Users can connect to other devices, send and receive messages, and enjoy a seamless chat experience.

## Features

- Scan for nearby Bluetooth devices
- Connect to selected devices
- Real-time messaging functionality
- User-friendly interface

## Project Structure

```
flutter-bluetooth-app
├── lib
│   ├── main.dart                # Entry point of the application
│   ├── screens
│   │   ├── home_screen.dart     # Main interface for Bluetooth connections
│   │   └── chat_screen.dart     # Chat interface for messaging
│   ├── services
│   │   └── bluetooth_service.dart # Handles Bluetooth functionality
│   ├── models
│   │   └── message_model.dart    # Represents a message object
│   └── widgets
│       └── message_widget.dart   # UI component for displaying messages
├── pubspec.yaml                  # Project configuration and dependencies
└── README.md                     # Project documentation
```

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd flutter-bluetooth-app
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the application:
   ```
   flutter run
   ```

## Usage

- Open the app and navigate to the Home Screen to scan for Bluetooth devices.
- Select a device to connect and proceed to the Chat Screen to start messaging.

## Dependencies

Ensure to include necessary Bluetooth libraries in the `pubspec.yaml` file for Bluetooth functionality.