# Muni Tracker

> Work in Progress

A native iOS app for tracking real-time SF Muni bus arrivals and locations. Inspired by the removal of a popular Muni app from the App Store that many riders, particularly seniors, relied on daily. Built as a portfolio project using SwiftUI, MVVM architecture, and live data from the 511 SF Bay API.

---

## Features

- **511 SF Bay API** - live data integration *(complete)*
- **Nearby Stop Times** - real-time arrival predictions for Muni stops near you *(in-progress)*
- **Live Bus Map** - real-time bus locations on a MapKit map *(coming soon)*
- **Favorites** - save frequently used lines, stored locally on device *(coming soon)*
- **Route Search** - search any Muni route by line number *(coming soon)*
- **Localization and multi-language support** - languages include Chinese and Spanish *(coming soon)*

## Tech Stack
- SwiftUI - declarative UI framework
- Swift Concurrency - non-blocking network requests |
- MapKit - live bus location map
- SwiftData - local favorites persistence
- MVVM Architecture
- 511 SF Bay API - Real-time transit data 

## Architecture
This app follows the **MVVM (Model-View-ViewModel)**:
- **Models** - `BusArrival`, `BusArrivalResponse` (data structures, API response mapping)
- **ViewModels** - `BusArrivalViewModel` (handles networking, JSON parsing, state management)
- **Views** - `ContentView`, `BusArrivalRow` (declarative UI)
- **Utilities** - `SecretsManager`, `KeychainManager` (secure API token storage and access via iOS Keychain)

## Security
- API credentials are stored using iOS Keychain Services
- A custom KeychainManager wrapper handles secure save, read, and delete operations for stored credentials
- `Secrets.plist` is used only as a one-time migration source on first app launch, and is excluded from version control via .gitignore

## Getting Started
### Prerequisites
- Xcode 15
- A Free 511 SF Bay API token (https://511.org/open-data)

### Setup
1. Clone the repo
2. Create a `Secrets.plist` file in the project root (this file is gitignored and must be created locally)
    ```
    Key: API_KEY
    Type: String
    Value: [Your-511-Token]
    ```
    
    ```
    Note: 'Secrets.plist' is only used to seed the API key into iOS Keychain on first launch.
    ```
    
3. Open `MuniTracker.xcodeproj` in Xcode and run on an iOS device.

## API
This app uses the **511 SF Bay Real-Time Arrivals API (https://511.org/open-data/transit)**, free publicly available transit data covering the Bay Area.

Key endpoint: https://api.511.org/transit/StopMonitoring?api_key=YOUR_KEY&agency=SF&stopCode=STOP_ID&format=json

Responses are decoded using nested `Codable` structs in `BusArrivalResponse.swift`. 
