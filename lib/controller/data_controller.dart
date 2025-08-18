
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/save_model.dart';

class DataController extends ChangeNotifier {
  List<SaveModel> _bookmarks = [];

  List<SaveModel> get bookmarks => _bookmarks;


  /// বুকমার্ক লোড
  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList('bookmarkedPages') ?? [];


    _bookmarks = bookmarksJson.map((e) {
      try {
        final decoded = jsonDecode(e);

        if (decoded is int || decoded is String) {
          // পুরনো ডাটা fallback
          return SaveModel(
            decoded.toString(),
            "old_date", "old_time",
          );
        }

        return SaveModel.fromJson(decoded as Map<String, dynamic>);
      } catch (err) {
        print("⚠️ Error decoding bookmark: $e ($err)");
        return SaveModel("?", "?", "?");
      }
    }).toList();

    notifyListeners();
  }


  /// বুকমার্ক ডিলিট করা
  Future<void> removeBookmark(String page) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList('bookmarkedPages') ?? [];

    bookmarksJson.removeWhere(
            (e) {
              try {
                final decoded = jsonDecode(e);
                if (decoded is Map<String, dynamic>) {
                  return decoded['page'] == page;
                } else {
                  // পুরনো format (int বা string) handle
                  return decoded.toString() == page.toString();
                }
              } catch (err) {
                // unexpected format
                return false;
              }
            });

    await prefs.setStringList('bookmarkedPages', bookmarksJson);

    _bookmarks.removeWhere((bookmark) => bookmark.page == page);
    notifyListeners();
  }



  Future<void> toggleBookmarks(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList('bookmarkedPages') ?? [];

    // আগের বুকমার্ক খুঁজে বের করো
    final exists = _bookmarks.any((b) => b.page == page.toString());

    if (exists) {
      // শুধু রিমুভ করো (সময় আপডেট কোরো না)
      bookmarksJson.removeWhere(
              (e) => SaveModel.fromJson(jsonDecode(e)).page == page.toString());
      _bookmarks.removeWhere((b) => b.page == page.toString());
    } else {
      // শুধু তখনই নতুন সময়/তারিখ সহ বুকমার্ক বানাও
      final now = DateTime.now();
      final model = SaveModel(
        page.toString(),
        DateFormat('hh:mm a').format(now),        // 12-hour AM/PM format
        DateFormat('yyyy-MM-dd').format(now),
      );

      bookmarksJson.add(jsonEncode(model.toJson()));
      _bookmarks.add(model);
    }

    await prefs.setStringList('bookmarkedPages', bookmarksJson);
    notifyListeners();
  }

  /// বুকমার্ক লিস্ট update করা (bottom sheet থেকে)
  Future<void> updateBookmarks(List<SaveModel> updatedList) async {
    final prefs = await SharedPreferences.getInstance();

    // SharedPreferences-এ JSON list হিসেবে save করো
    List<String> bookmarksJson =
    updatedList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('bookmarkedPages', bookmarksJson);

    // Provider-এর লিস্ট update
    _bookmarks = updatedList;
    notifyListeners();
  }


}