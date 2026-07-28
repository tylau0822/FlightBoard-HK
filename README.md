# ✈️ HK Flight Board

A modern SwiftUI application that displays flight information for **Hong Kong International Airport (HKG)**.

Users can browse **Arrivals** and **Departures Flights**, search by flight number or airport, and view detailed flight information including terminals, gates, baggage belts, and city names.

---

## 📱 Features

### ✈️ Flight Information
- View Arrival Flights
- View Departure Flights
- Browse historical flight schedules by date

### 🔍 Search
Search flights by:
- Flight Number (`CX251`)
- Airport Code (`ICN`, `NRT`, `LAX`)

### 📅 Date Selection
- Select any available date
- Automatically refresh all flight tabs

### 🌍 Airport Lookup
Convert IATA airport codes into readable city names.

Examples:

| Airport Code | City |
|-------------|------|
| ICN | Seoul |
| NRT | Tokyo |
| LAX | Los Angeles |

---

## 🏗 Architecture

The project follows a clean architecture using **MVVM**, **Repository Pattern**, and **Dependency Injection**.

```text
View
 ↓
ViewModel
 ↓
Repository
 ↓
API Service
 ↓
API Client
```

### Presentation Layer

#### MainFlightBoardView
Responsible for:

- Tab Navigation
- Search Bar
- Date Picker

#### FlightListView
Displays a list of flights.

#### FlightRowView
Displays individual flight cards.

---

### ViewModel Layer

#### FlightListViewModel

Responsibilities:

- Load flight data
- Filter flights
- Manage view state

```swift
func loadFlights(date: Date) async

func filterFlights()
```

---

### Repository Layer

#### FlightRepository

Responsible for:

- Fetching flight information
- Mapping API models into domain models

```swift
protocol FlightRepositoryProtocol {
    func getFlights(
        date: Date,
        category: FlightCategory
    ) async throws -> [FlightSchedule]
}
```

#### AirportRepository

Responsible for:

- Loading local airport database
- Converting airport codes into city names

```swift
func city(for code: String) -> String
```

---

### Service Layer

#### APIService

Builds API requests and decodes responses.

```swift
func fetchArrivalFlights(...)
func fetchDepartureFlights(...)
```

---

### Networking Layer

#### APIClient

A generic networking layer using Swift Concurrency.

```swift
func get<T: Decodable>(url: URL) async throws -> T
```

Features:

- Generic Decoding
- Async/Await
- Error Handling
- Easily Mockable

---

## 🔄 Dependency Injection

A lightweight dependency container is used to manage dependencies.

```swift
DIContainer.shared
```

Example:

```swift
let viewModel = DIContainer.shared
    .makeFlightListViewModel(
        category: .arrival
    )
```

Benefits:

- Better Testability
- Easier Mocking
- Centralized Dependency Management

---

## 📦 Models

### FlightSchedule

Represents a flight displayed by the UI.

```swift
struct FlightSchedule {
    let scheduledTime: String
    let airlines: [Flight]
    let status: String
    let locationCode: [String]?
    let terminal: String?
    let gate: String?
}
```

### Flight

```swift
struct Flight {
    let flightNumber: String
    let airlineCode: String
}
```

---

## 🌍 Airport Database

The application includes a local airport database:

```text
airports.json
```

Used for converting airport codes into city names.

Example:

```swift
airportRepository.city(for: "ICN")
// Seoul
```

---

## 🔗 Data Source

Flight data is provided by the Hong Kong International Airport public API:

```text
https://www.hongkongairport.com/flightinfo-rest/rest/flights/past
```

Example Request:

```http
GET /flights/past
    ?date=2026-07-23
    &lang=en
    &arrival=true
    &cargo=false
```

---

## 🗂 Project Structure

```text
HKFlightBoard
│
├── App
│   ├── FlightBoardApp.swift
│   └── DIContainer.swift
│
├── Views
│   ├── MainFlightBoardView.swift
│   ├── FlightListView.swift
│   ├── FlightRowView.swift
│   └── Components
│
├── ViewModels
│   └── FlightListViewModel.swift
│
├── Repositories
│   ├── FlightRepository.swift
│   └── AirportRepository.swift
│
├── Services
│   ├── APIService.swift
│   └── APIClient.swift
│
├── Models
│   ├── Domain
│   └── DTO
│
├── Resources
│   └── airports.json
│
└── Utilities
    ├── DateFormatting.swift
    └── APIError.swift
```

---

## 🚀 Future Improvements

- [ ] Pull to Refresh
- [ ] Flight Detail Screen
- [ ] Airport Detail Screen
- [ ] Favorite Flights
- [ ] Flight Status Color Indicators
- [ ] Local Data Caching
- [ ] Unit Tests
- [ ] UI Tests
- [ ] Dark Mode Optimization

---

## 🧪 Technical Highlights

### SwiftUI
- NavigationStack
- TabView
- State Management
- Reusable Components

### Concurrency
- Async/Await
- URLSession

### Architecture
- MVVM
- Repository Pattern
- Dependency Injection
- Protocol-Oriented Design

### Testing Friendly
- Protocol-based abstractions
- Mockable API Client
- Decoupled business logic

---

## 📸 Screenshots

### Arrival Flights

> Add screenshot here

### Departure Flights

> Add screenshot here

---

## 👩‍💻 Author

**Katy Lau**

Mobile Developer with 5+ years of experience building iOS and cross-platform applications using:

- Swift
- SwiftUI
- Objective-C
- Flutter

### Connect

- LinkedIn: *https://www.linkedin.com/in/katy-lty/*
- GitHub: *https://github.com/tylau0822*

---

⭐ If you found this project helpful, feel free to star the repository.
