import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/surah_model.dart';
import '../models/surah_translation_model.dart';

class ApiServices {
  Future<SurahModel> getSurah() async {
    try {
      // * Check if data is cached
      final cachedData = await _getCacheData('surahCacheKey');
      if (cachedData != null) {
        return SurahModel.fromJson(jsonDecode(cachedData));
      }

      // * If not cached, make the HTTP request
      final res = await http
          .get(Uri.parse("http://api.alquran.cloud/v1/quran/quran-uthmani"));
      Map<String, dynamic> data = jsonDecode(res.body.toString());

      if (res.statusCode == 200) {
        // Cache the data for future use
        _cacheData('surahCacheKey', res.body.toString());
        return SurahModel.fromJson(data);
      } else {
        print("Failed to fetch data. Status code: ${res.statusCode}");
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error occurred");
    }
  }

  // * Helper function to cache data
  Future<void> _cacheData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  // * Helper function to retrieve cached data
  Future<String?> _getCacheData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<SurahTransaltionModel> getSurahDetails(int suraNumber) async {
    try {
      // Check if data is cached
      final cachedData = await _getCacheData('translationCacheKey$suraNumber');
      if (cachedData != null) {
        return SurahTransaltionModel.fromJson(jsonDecode(cachedData));
      }

      // If not cached, make the HTTP request
      final res = await http.get(Uri.parse(
          "https://quranenc.com/api/v1/translation/sura/somali_yacob/$suraNumber"));
      Map<String, dynamic> data = jsonDecode(res.body.toString());

      if (res.statusCode == 200) {
        // Cache the data for future use
        _cacheData('translationCacheKey$suraNumber', res.body.toString());
        return SurahTransaltionModel.fromJson(data);
      } else {
        print("Failed to fetch data. Status code: ${res.statusCode}");
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      print("Error======================================>: $e");
      throw Exception("Error occurred $e");
    }
  }

  List<Surah> searchSurahs(SurahModel surahModel, String query) {
    final surahList = surahModel.data
        .surahs; // Assuming SurahModel has a `surahs` property of type List<Surah>
    final filteredSurahs = surahList.where((surah) {
      return surah.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return filteredSurahs;
  }
}
