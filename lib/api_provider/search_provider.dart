import 'package:flutter/material.dart';

class DocumentSearchProvider extends ChangeNotifier {
  late List<dynamic> _filteredDocList;
  late TextEditingController _searchController;
  String _searchQuery = '';

  DocumentSearchProvider(List<dynamic> initialList) {
    _filteredDocList = initialList;
    _searchController = TextEditingController();
  }

  List<dynamic> get filteredDocList => _filteredDocList;
  TextEditingController get searchController => _searchController;
  String get searchQuery => _searchQuery;

  void updateSearch(String query, List<dynamic> fullList) {
    _searchQuery = query;
    _filteredDocList = fullList
        .where((doc) => doc.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

class JobSearchProvider extends ChangeNotifier {
  late List<dynamic> _filteredJobList;
  final TextEditingController searchController;

  JobSearchProvider({
    required List<dynamic> initialList,
    required this.searchController,
  }) {
    _filteredJobList = initialList;
    searchController.addListener(_onSearchChanged);
  }

  List<dynamic> get filteredJobList => _filteredJobList;
  String get searchQuery => searchController.text;

  void _onSearchChanged() {
    updateSearch(searchQuery);
  }

  void updateSearch(String query) {
    // Replace the condition as per your filtering logic
    _filteredJobList = _filteredJobList
        .where((job) => job.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
