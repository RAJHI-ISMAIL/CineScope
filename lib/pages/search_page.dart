import 'package:flutter/material.dart';
import '../services/omdb_api_service.dart';
import '../models/movie.dart';
import 'movie_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final OmdbApiService _apiService = OmdbApiService();
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _performSearch() async {
    String query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a search term';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _searchResults = [];
    });

    try {
      print('Searching for: $query'); // Debug log
      final results = await _apiService.searchMovies(query);
      print('Received ${results.length} results'); // Debug log

      setState(() {
        _searchResults = results;
        _isLoading = false;
        if (results.isEmpty) {
          _errorMessage =
              'No results found for "$query".\nTry different keywords.';
        }
      });
    } catch (e) {
      print('Search error: $e'); // Debug log
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Error searching movies.\nCheck your internet connection.';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          onSubmitted: (value) {
                            _performSearch();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: _performSearch,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Display search results or trending section
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF8282),
                      ),
                    ),
                  )
                else if (_searchResults.isNotEmpty)
                  // Search Results Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = _searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailPage(
                                imdbID: movie.imdbID,
                                title: movie.title,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[800],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: movie.poster != 'N/A'
                                      ? Image.network(
                                          movie.poster,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return const Center(
                                                  child: Icon(
                                                    Icons.movie,
                                                    color: Colors.white54,
                                                    size: 50,
                                                  ),
                                                );
                                              },
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.movie,
                                            color: Colors.white54,
                                            size: 50,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${movie.year} • ${movie.type}',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                else if (_errorMessage.isNotEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  // Default view - empty state
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Icon(Icons.search, size: 80, color: Colors.grey[700]),
                          const SizedBox(height: 24),
                          Text(
                            'Search for movies and series',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter a title to get started',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
