# Service Provider Booking App

This is a Flutter application that allows users to find and book service providers.

## Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Mubaola23/service-provider-booking
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd service_provider_booking
    ```
3.  **Get the dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the application:**
    ```bash
    flutter run
    ```

## Approach and Architecture

### Project Structure

The project follows a standard Flutter project structure, with the core application logic located in the `lib` directory. The `lib` directory is further organized into the following subdirectories:

*   `models`: Contains the data models for the application (e.g., `Provider`).
*   `screens`: Contains the individual screens of the application (e.g., `ProviderListScreen`, `BookingScreen`).
                `providers`: Contains the Riverpod providers for state management.
*   `widgets`: Contains reusable widgets used across multiple screens (e.g., `ProviderCard`).

### State Management

The application uses the `hooks_riverpod` package for state management. This choice was made to ensure a clean, scalable, and testable architecture. The key providers used are:

*   `providerListProvider`: A `StateNotifierProvider` that manages the state of the provider list screen, including the search query and the filtered list of providers.
*   `bookingProvider`: A `StateNotifierProvider.family` that manages the state of the booking screen, including the selected date, time, duration, and total price.

### UI

The UI is built using Material Design components and is based on the provided design references. A consistent theme has been applied throughout the application to ensure a cohesive user experience.

## Time Log

| Phase                       | Estimated Time |
| --------------------------- | -------------- |
| Planning & Clarification    | 20 minutes     |
| Project Setup               | 15 minutes     |
| UI Development (Screens & Widgets) | 45 minutes      |
| Documentation (README)      | 15 minutes     |
| **Total**                   | **~1.35 hours**|
