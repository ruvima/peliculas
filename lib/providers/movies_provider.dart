import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {

final String _apiKey   ='46f3718ec738841e4d528baf1db32b09';
final String _baseUrl  = 'api.themoviedb.org';
final String _language = 'es-ES';

List<Movie> onDisplayMovies = [];
List<Movie> popularMovies = [];
Map<int, List<Cast>> moviesCast = {};

int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url =
        Uri.https(_baseUrl, endpoint,{
          'api_key': _apiKey,
          'language': _language,
          'page': '$page',
  });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;

  }

  getOnDisplayMovies() async {
  final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async{
    _popularPage++;
   final jsonData = await _getJsonData('3/movie/popular', );
    final popularResponse = PopularResponse.fromJson(jsonData);
   popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();

  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

  final jsonData =
   await _getJsonData('3/movie/$movieId/credits');

  final creditsResponse = CreditsResponse.fromJson(jsonData);

  moviesCast[movieId] = creditsResponse.cast;
  return creditsResponse.cast;
  }
}
