import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class OmdbApiService {
  // API key from https://www.omdbapi.com/apikey.aspx
  static const String _apiKey = '54844d50';
  static const String _baseUrl = 'https://www.omdbapi.com/';

  // Search for movies/series by title
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      final url = Uri.parse('$_baseUrl?apikey=$_apiKey&s=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['Response'] == 'True') {
          final List<dynamic> results = data['Search'];
          return results.map((json) => Movie.fromJson(json)).toList();
        } else {
          // No results found
          return [];
        }
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print('Error searching movies: $e');
      return [];
    }
  }

  // Get detailed information about a movie/series by ID
  Future<MovieDetail?> getMovieDetails(String imdbID) async {
    try {
      final url = Uri.parse('$_baseUrl?apikey=$_apiKey&i=$imdbID&plot=full');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['Response'] == 'True') {
          return MovieDetail.fromJson(data);
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      print('Error getting movie details: $e');
      return null;
    }
  }
}
