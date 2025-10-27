# CineScope - Movie & Series Search App 🎬

A Flutter mobile application that allows users to search for movies and TV series using the OMDB API.

## Features

- ✨ Welcome screen with smooth navigation
- 🔍 Search for movies and TV series
- 📱 Grid view of search results with posters
- 📄 Detailed information page for each movie/series
- ⭐ IMDb ratings display
- 🎨 Modern dark theme UI

## Setup Instructions

### 1. Get Your OMDB API Key

1. Visit [https://www.omdbapi.com/apikey.aspx](https://www.omdbapi.com/apikey.aspx)
2. Choose the FREE plan (1,000 daily requests)
3. Enter your email address
4. Check your email and verify your API key
5. Copy your API key

### 2. Add Your API Key to the App

Open `lib/services/omdb_api_service.dart` and replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String _apiKey = 'your-actual-api-key-here';
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                      # App entry point
├── models/
│   └── movie.dart                 # Movie and MovieDetail models
├── services/
│   └── omdb_api_service.dart      # OMDB API integration
└── pages/
    ├── welcome_page.dart          # Welcome/splash screen
    ├── search_page.dart           # Search and results page
    └── movie_detail_page.dart     # Movie details page
```

## How to Use

1. **Welcome Screen**: Tap "Get Started" to begin
2. **Search**: Enter a movie or series name and press search
3. **Browse Results**: View search results in a grid layout
4. **View Details**: Tap any movie/series to see full information including:
   - Plot summary
   - Cast and crew
   - IMDb rating
   - Release information
   - Awards (if any)

## API Information

This app uses the [OMDB API](https://www.omdbapi.com/) to fetch movie and TV series data.

**API Endpoints Used:**
- Search: `https://www.omdbapi.com/?apikey={key}&s={query}`
- Details: `https://www.omdbapi.com/?apikey={key}&i={imdbID}&plot=full`

## Dependencies

- `http: ^1.1.0` - For API requests
- `cupertino_icons: ^1.0.8` - iOS-style icons

## Notes

- The free OMDB API tier has a limit of 1,000 requests per day
- Make sure to add your own API key before running the app
- Internet connection is required for the app to work

## Future Enhancements

- [ ] Add favorites/watchlist feature
- [ ] Implement local caching
- [ ] Add filtering by year, type, etc.
- [ ] Add movie trailers
- [ ] Add user reviews and ratings

---

Made with ❤️ using Flutter
