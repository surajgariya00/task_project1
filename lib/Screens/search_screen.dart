import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _showList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 41),
            child: Text(
              'TVMaze Shows',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: const TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[900],
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                _getFilteredSuggestions(value);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _showList.length,
                itemBuilder: (context, index) {
                  final show = _showList[index]['show'];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.grey[900], // Darker background for cards
                    child: ListTile(
                      leading: show['image'] != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                show['image']['medium'],
                              ),
                            )
                          : const SizedBox.shrink(),
                      title: Text(
                        show['name'] ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle item tap
                        print('Selected suggestion: ${show['name']}');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchShowListByTitle(String title) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$title'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _getFilteredSuggestions(String query) {
    if (query.isNotEmpty) {
      fetchShowListByTitle(query).then((value) {
        setState(() {
          _showList = value;
        });
      }).catchError((error) {
        print('Error fetching suggestions: $error');
      });
    } else {
      setState(() {
        _showList = [];
      });
    }
  }
}
