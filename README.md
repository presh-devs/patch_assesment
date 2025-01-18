# Patch Assessment Documentation

## Table of Contents
1. [Overview](#overview)
2. [Project Structure](#project-structure)
3. [Architecture](#architecture)
4. [Dependencies](#dependencies)
5. [Setup Instructions](#setup-instructions)
6. [Features](#features)
7. [State Management](#state-management)
8. [API Integration](#api-integration)
9. [Assets](#assets)


## Overview
### Description
This assessment implements a product feed for mobile shoppers, providing functionalities to:
- View a product feed.
- Sort products based on price (ascending or descending).
- Filter products based on categories.

### Target Platform
- iOS
- Android


## Project Structure
```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── themes/
│   ├── utils/
│   └── services/
├── features/
│   ├── home/
│   │   ├── model/
│   │   ├── view_model/
│   │   └── view/
│   └── feature2/
└── widgets/
  
```

## Architecture
### Design Pattern
MVVM Architecture was used.

### Layer Description
- **Model**: Data layer and low-level tasks such as making HTTP requests are handled here, 
- **View Model**: Binds the View to the Model
- **View**: UI components and state management

## Dependencies
### Major Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
    dio: ^5.7.0
  http: ^1.2.2
  pretty_dio_logger: ^1.4.0
  provider: ^6.1.2
```

## Setup Instructions
### Prerequisites
1. Install Flutter SDK
    - Download Flutter SDK from flutter.dev
    - Add Flutter to your system PATH
    - Run flutter doctor to verify installation and dependencies


2. Install Development Tools (skip if development tools already installed)
    - Install Android Studio (for Android development)
    - Install Xcode (for iOS development, Mac only)
    - Install VS Code or your preferred IDE
    - Install Flutter and Dart plugins for your IDE

### Installation Steps
1. Clone repository
    # Using HTTPS
    git clone https://github.com/presh-devs/patch_assesment

# Navigate to project directory
    cd patch_assessment

2. Install Dependecies
    # Get all packages specified in pubspec.yaml
    flutter pub get

    # If using FVM (Flutter Version Management)
    fvm flutter pub get

3. Run the application
    # Run on default device
    flutter run

    # Run on specific device
    flutter run -d <device-id>

## Features
### Current Features
- Feature 1: Filter products based on the categories fetched from the API
- Feature 2: Sort the products by price, both in ascending and descending order


## API Integration
### API Documentation
- Base URL = [text](https://fakestoreapi.com/)
- Authentication method : none


## Assets
### Resources
```
assets/
├── images/

fonts/

```
