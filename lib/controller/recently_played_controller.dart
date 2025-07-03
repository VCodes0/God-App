import 'dart:convert';
import 'dart:developer';

import 'package:aarati_app/model/recently_played_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RecentlyPlayedController extends ChangeNotifier {
  List<RecentlyPlayed> _recentlyPlayed = [];
  List<RecentlyPlayed> get recentlyPlayed => _recentlyPlayed;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Dio dio = Dio();
  final String url =
      "https://appy.trycatchtech.com/v3/all_god/trending_aarti?category_id=1,3";

  Future<void> getRecentlyPlayedData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> decodeData = jsonDecode(response.data);
        _recentlyPlayed = RecentlyPlayed.getRecentPlayed(decodeData);
      } else {
        log('Failed response: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching recently played data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
