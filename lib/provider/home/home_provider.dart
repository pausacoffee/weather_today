import 'package:flutter/material.dart';

import '../../repository/weather/weather_repository.dart';

class HomeProvider extends ChangeNotifier {
  WeatherRepository _movieRepository = WeatherRepository();
  // List<Movie> _movies = [];

  // List<Movie> get movies => _movies;
  // loadMovies() async {
  //   List<Movie> listMovies = await _movieRepository.loadMovies();
  //   _movies = listMovies;
  //   notifyListeners();
  // }

  // clearMovies() {
  //   _movies.clear();
  // }
}
