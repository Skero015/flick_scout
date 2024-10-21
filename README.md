# flick_scout

A Flutter application that allows users to search for movies using the OMDb API and displays the results in a user-friendly interface.  This app demonstrates the use of the BLoC pattern for state management, API integration, error handling, and responsive UI design.

## Overview

This app allows users to search for movies by title. The home screen displays a search bar and a grid of movie cards. Each card shows the movie poster, title, year, and type.  Tapping a card navigates to a detail screen, displaying additional information about the selected movie, including the plot, cast, ratings, and more.

## Features

* **Search:** Search for movies by title using the search bar.  Real-time search with debouncing is implemented for a smooth user experience.
* **Movie List:** Displays search results in a responsive grid layout.
* **Movie Details:** View detailed information about a selected movie, including the plot summary, cast, ratings, awards, and other details.
* **Error Handling:** Handles various error scenarios, including network errors, API errors, and "movie not found" cases, providing informative messages to the user.
* **Loading State:** Displays a shimmer effect while loading data, mimicking the UI for a better user experience.
* **Empty State:**  Provides a message prompting the user to search when no movies are found or when the search query is empty.
* **Responsive UI:** Adapts to different screen sizes for a consistent look and feel across devices.
* **Hero Animation:** Uses the Hero widget for smooth image transitions between the movie list and detail screen.

## Technical Details

* **State Management:**  Implements the BLoC (Business Logic Component) pattern for predictable state management and separation of concerns.
* **API Integration:**  Uses the OMDb API to fetch movie data.
* **Networking:** Uses the `http` package for making HTTP requests.
* **Image Loading and Caching:** Uses the `cached_network_image` package for efficient image loading and caching.
* **Responsive UI:**  Uses `MediaQuery` and layout builder techniques for handling responsive design without external packages.
* **JSON Serialization:** Uses manual JSON parsing, keeping the project lean.
* **Asynchronous Operations:**  Uses `async`/`await` and `Future`s for asynchronous operations.
* **Error Handling:** Implements robust error handling with easy to read and detailed error messages using try-catch.
* **Unit and Widget Testing:** Includes unit tests for the BLoC and repository and widget tests for UI interactions. Uses `mocktail` for mocking in tests.

## Getting Started

1. **Clone the repository:** `git clone <repository_url>`
2. **Install dependencies:** `flutter pub get`
3. **Run the app:** `flutter run`

**API Key:**

You'll need to obtain an API key from [OMDb API](http://www.omdbapi.com/) and replace `"YOUR_API_KEY"` with your actual key in the `lib/core/utils/constants.dart` file (include a .env file in the project root and put API_KEY='Your api key' ).


## Dependencies

* `flutter_bloc`: For BLoC state management.
* `http`: For making HTTP requests.
* `cached_network_image`: For image caching and loading.
* `shimmer`: For shimmer loading effects.
* `bloc_test`: For testing blocs
* `mocktail`: For mocking dependencies in unit tests.
* `flutter_dotenv`:  For loading environment variables from a .env file.
* `sizer`: For responsive UI design (sizing and spacing).
* `shimmer`: For creating shimmer loading effects.
* `flutter_svg`: For displaying SVG images 

## Folder structure
movie_search_app/
├── lib
│ ├── main.dart
│ ├── core
│ │ ├── api
│ │ │ └── omdb_api_client.dart
│ │ ├── models
│ │ │ └── movie.dart
│ │ ├── singleton
│ │ │ └── http_client_singleton.dart
│ │ ├── utils
│ │ │ └── constants.dart
│ │ └── widgets
│ │ └── movie_card.dart
│ ├── features
│ │ └── movie_search
│ │ ├── bloc
│ │ │ ├── movie_search_bloc.dart
│ │ │ ├── movie_search_event.dart
│ │ │ ├── movie_search_state.dart
│ │ ├── data
│ │ │ ├── movie_repository.dart
│ │ ├── presentation
│ │ │ ├── home_screen.dart
│ │ │ ├── movie_detail_screen.dart
│ │ │ └── widgets
│ │ │ └── search_bar.dart
│ ├── app.dart
│ └── routes.dart
└── test
├── unit
│ └── movie_search_bloc_test.dart
└── widget
└── home_screen_test.dart

## Assumptions and Decisions

* The app focuses on searching movies by title.
* Error handling prioritizes user-friendly messages over detailed technical information.
* Manual json parsing was used.
* The app uses a simple, clean UI design.

## Potential Improvements

* **Pagination:** Implement pagination for search results to handle large datasets.
* **Local Storage:** Add local storage to cache movie data and improve offline capabilities.
* **Filtering and Sorting:**  Add options to filter movies by genre, year, or rating, and allow sorting by different criteria.
* **Favorites:** Allow users to save their favorite movies.
* **Theming:** Implement a more sophisticated theming solution.

