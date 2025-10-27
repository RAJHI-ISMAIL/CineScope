import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/omdb_api_service.dart';

class MovieDetailPage extends StatefulWidget {
  final String imdbID;
  final String title;

  const MovieDetailPage({super.key, required this.imdbID, required this.title});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final OmdbApiService _apiService = OmdbApiService();
  MovieDetail? _movieDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMovieDetails();
  }

  Future<void> _loadMovieDetails() async {
    final details = await _apiService.getMovieDetails(widget.imdbID);
    setState(() {
      _movieDetail = details;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF8282)),
            )
          : _movieDetail == null
          ? Center(
              child: Text(
                'Failed to load movie details',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            )
          : CustomScrollView(
              slivers: [
                // App Bar with back button and title
                SliverAppBar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    _movieDetail!.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Poster Image
                      if (_movieDetail!.poster != 'N/A')
                        Container(
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(color: Colors.grey[900]),
                          child: Image.network(
                            _movieDetail!.poster,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.movie,
                                  color: Colors.white54,
                                  size: 100,
                                ),
                              );
                            },
                          ),
                        ),

                      const SizedBox(height: 20),

                      // Info Badges (Seasons, IMDb, Year)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (_movieDetail!.totalSeasons != null)
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'total Seasons',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _movieDetail!.totalSeasons!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (_movieDetail!.totalSeasons != null)
                              const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'imdbRating',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _movieDetail!.imdbRating,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Year',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _movieDetail!.year,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Star Rating Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            double rating =
                                double.tryParse(_movieDetail!.imdbRating) ?? 0;
                            double starValue = (rating / 2);

                            if (index < starValue.floor()) {
                              return const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 24,
                              );
                            } else if (index < starValue) {
                              return const Icon(
                                Icons.star_half,
                                color: Colors.white,
                                size: 24,
                              );
                            } else {
                              return const Icon(
                                Icons.star_border,
                                color: Colors.white,
                                size: 24,
                              );
                            }
                          }),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Plot Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8B4B8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Plot :',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _movieDetail!.plot,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Additional Info
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildModernInfoRow('Genre', _movieDetail!.genre),
                            _buildModernInfoRow(
                              'Director',
                              _movieDetail!.director,
                            ),
                            _buildModernInfoRow('Actors', _movieDetail!.actors),
                            _buildModernInfoRow(
                              'Released',
                              _movieDetail!.released,
                            ),
                            _buildModernInfoRow(
                              'Runtime',
                              _movieDetail!.runtime,
                            ),
                            _buildModernInfoRow(
                              'Language',
                              _movieDetail!.language,
                            ),
                            _buildModernInfoRow(
                              'Country',
                              _movieDetail!.country,
                            ),
                            if (_movieDetail!.awards != 'N/A')
                              _buildModernInfoRow(
                                'Awards',
                                _movieDetail!.awards,
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildModernInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Color(0xFFFF8282),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[300], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
