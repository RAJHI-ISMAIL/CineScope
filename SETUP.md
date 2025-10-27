# Quick Setup Guide

## Add Your API Key

Replace `YOUR_API_KEY_HERE` with `54844d50` in the file:
`lib/services/omdb_api_service.dart`

Change this line:
```dart
static const String _apiKey = 'YOUR_API_KEY_HERE';
```

To:
```dart
static const String _apiKey = '54844d50';
```

Then run:
```bash
flutter run
```

That's it! Your app should now be working with the OMDB API! 🎬
