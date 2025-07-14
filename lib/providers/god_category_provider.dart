import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/god_category_model.dart';

class GodCategoryProvider extends ChangeNotifier {
  final dio = Dio();
  final String url =
      "https://appy.trycatchtech.com/v3/all_god/all_god_wallpaper_category_list";

  List<Data> _originalGodCategories = [];
  List<Data> _filteredGodCategories = [];
  List<Data> get filteredCategories => _filteredGodCategories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchGodCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> decoded = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        if (decoded['data'] != null && decoded['data'] is List) {
          _originalGodCategories = Data.getData(decoded['data']);
          _filteredGodCategories = List.from(_originalGodCategories);

          SharedPreferences sh = await SharedPreferences.getInstance();
          sh.setString('godCategories', jsonEncode(decoded['data']));
        }
      }
    } catch (e) {
      log('Error fetching god categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterGodCategories(String query) {
    if (query.isEmpty) {
      _filteredGodCategories = List.from(_originalGodCategories);
    } else {
      _filteredGodCategories = _originalGodCategories
          .where(
            (item) => (item.catName ?? '').toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
    }
    notifyListeners();
  }
}
