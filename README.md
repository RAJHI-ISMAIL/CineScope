# CineScope - Movie & Series Search App 🎬

A beautiful Flutter mobile application that allows users to search for movies and TV series using the OMDB API. Features a modern dark theme with coral accents and an intuitive user interface.

## Features

- ✨ **Welcome Screen** - Elegant welcome page with app logo and smooth navigation
- 🔍 **Smart Search** - Search for movies and TV series with real-time results
- 📱 **Grid View** - Browse search results in a responsive grid layout with posters
- 🎬 **Movie Details** - Professional detail page with:
  - Movie title in the app bar
  - Full-width poster image
  - Modern info badges (Seasons, IMDb Rating, Year)
  - Star rating visualization (5-star system)
  - Comprehensive plot summary
  - Cast, crew, and production details
- ⭐ **IMDb Integration** - Display official IMDb ratings with star icons
- 🎨 **Modern UI** - Dark theme with coral (#FF8282) and rose (#E8B4B8) accents
- 📺 **TV Series Support** - Shows total seasons for TV series
- 🔄 **Smooth Navigation** - Intuitive navigation between pages

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

> **Note**: The API key must be activated via the verification email before it will work.

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

## Screenshots

### Welcome Page
- App logo centered on screen
- Coral-colored "Get Started" button

### Search Page
- Clean search bar at the top
- Empty state with search icon and instructions
- Grid layout of movie posters when results are displayed

### Movie Detail Page
- Movie title in the app bar next to back arrow
- Full-width poster image
- Three info badges showing:
  - Total Seasons (for TV series)
  - IMDb Rating with star icon
  - Release Year
- 5-star rating visualization based on IMDb score
- Plot summary in a rose-colored card
- Additional information (Genre, Director, Actors, etc.)

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

1. **Welcome Screen**: Launch the app and tap the coral "Get Started" button
2. **Search**: Enter a movie or series name in the search bar and tap the search button
3. **Browse Results**: Scroll through search results displayed in a grid with movie posters
4. **View Details**: Tap any movie/series card to open the detail page featuring:
   - Movie/series title in the header
   - High-quality poster image
   - Quick info badges (Seasons for TV series, IMDb Rating, Year)
   - Visual star rating (out of 5 stars)
   - Complete plot synopsis
   - Cast, crew, and production information
   - Genre, runtime, language, and country details
   - Awards and recognitions (if available)

## Design System

### Color Palette
- **Primary (Coral)**: `#FF8282` - Used for buttons, labels, and primary accents
- **Secondary (Rose)**: `#E8B4B8` - Used for plot section and secondary cards
- **Background**: Black with dark gray cards for contrast
- **Text**: White and light gray for optimal readability

### UI Components
- **Cards**: Rounded corners with padding for organized content
- **Badges**: Dark gray containers with white text for info display
- **Icons**: Star icons for ratings, search icon for empty states
- **Typography**: Bold headers, regular body text with proper hierarchy

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
- **Important**: You must verify your API key via email before it becomes active
- Internet connection is required for the app to work
- The app includes debug logging for troubleshooting API issues
- Star ratings are calculated from IMDb scores (10-point scale converted to 5 stars)

## Troubleshooting

### "Invalid API key" Error
1. Make sure you've verified your email from OMDB
2. Check that you've copied the API key correctly to `omdb_api_service.dart`
3. Wait a few minutes after verification before testing

### No Results Found
1. Check your internet connection
2. Try a different search term (e.g., "Batman", "Breaking Bad")
3. Ensure the API key is active and properly configured

### UI Overflow Issues
All overflow issues have been resolved with Flexible widgets and proper text constraints.

## Future Enhancements

- [ ] Add favorites/watchlist feature
- [ ] Implement local caching for offline access
- [ ] Add filtering by year, genre, and type
- [ ] Add movie trailers integration
- [ ] Implement search history
- [ ] Add share functionality
- [ ] Support for multiple languages
- [ ] Add "Similar Movies" recommendations

## Version History

### v1.0.0
- Initial release with welcome page
- Search functionality with OMDB API integration
- Grid view of search results
- Professional movie detail page redesign
- Modern badge layout for movie information
- Star rating visualization
- Dark theme with coral and rose accents
- Fixed UI overflow issues
- Removed placeholder trending section

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests.

## License

This project is open source and available for educational purposes.

---

Made with ❤️ using Flutter | Powered by [OMDB API](https://www.omdbapi.com/)
