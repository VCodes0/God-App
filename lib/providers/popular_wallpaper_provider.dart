import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/popular_wallpaper_model.dart';

class PopularWallpaperProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  final String _url =
      "https://appy.trycatchtech.com/v3/all_god/trending_wallpaper?category_id=1,2";

  List<PopularWallpaper> _originalWallpapers = [];
  List<PopularWallpaper> _filteredWallpapers = [];

  List<PopularWallpaper> get popwallpapers => _filteredWallpapers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Fetch wallpapers from the API
  Future<void> fetchWallpapers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> decoded = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        if (decoded.isNotEmpty) {
          _originalWallpapers = PopularWallpaper.getPopularWallpaper(decoded);
          _filteredWallpapers = List.from(_originalWallpapers);

          SharedPreferences sh = await SharedPreferences.getInstance();
          sh.setString('cached_wallpapers', jsonEncode(decoded));
        } else {
          log('Decoded response is empty or not a list.');
        }
      } else {
        log('Invalid response status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Error fetching wallpapers: $e', stackTrace: stackTrace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Optional: Add filtering logic if needed in the future
  void filterWallpapers(String query) {
    _filteredWallpapers = _originalWallpapers
        .where(
          (wallpaper) =>
              wallpaper.id?.contains(query) == true ||
              wallpaper.postImage?.contains(query) == true,
        )
        .toList();
    notifyListeners();
  }
}
