import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config.dart';
import 'PlantGuideScreen.dart';

class PlantDetailsScreen extends StatefulWidget {
  @override
  _PlantDetailsScreenState createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  late int currentPage = 1;
  late int lastPage = 1;
  late Future<List<dynamic>> futurePlantDetails;
  late TextEditingController _searchController;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    futurePlantDetails = fetchPlantDetails();
  }

  Future<List<dynamic>> fetchPlantDetails() async {
    setState(() {
      isLoading = true;
    });

    final searchQuery = _searchController.text;
    final url = '$list_url&page=$currentPage&q=$searchQuery';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        lastPage = data['last_page'] ?? 1;
        return (data['data'] as List<dynamic>?)?.where((plant) => plant != null).toList() ?? [];
      } else {
        throw Exception('Failed to load plant details');
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error loading plant details: $error';
      });
      return [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void nextPage() {
    if (!isLoading && currentPage < lastPage) {
      setState(() {
        currentPage++;
        futurePlantDetails = fetchPlantDetails();
      });
    }
  }

  void previousPage() {
    if (!isLoading && currentPage > 1) {
      setState(() {
        currentPage--;
        futurePlantDetails = fetchPlantDetails();
      });
    }
  }

  void searchPlants(String query) {
    setState(() {
      currentPage = 1;
      futurePlantDetails = fetchPlantDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search plant names...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: searchPlants,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : FutureBuilder<List<dynamic>>(
        future: futurePlantDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}'));
          } else {
            final dataList = snapshot.data!;

            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final datum = dataList[index];
                return Card(
                  child: ListTile(
                    leading: datum['default_image'] != null
                        ? Image.network(
                      datum['default_image']['thumbnail'] ??
                          '',
                      width: 50,
                      height: 50,
                    )
                        : SizedBox(),
                    title: Text(datum['common_name'] ?? 'Unknown'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plant ID: ${datum['id']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          datum['scientific_name'] != null
                              ? (datum['scientific_name']
                          as List)
                              .join(', ')
                              : 'Unknown',
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantGuideScreen(
                            plantId: datum['id'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentPage != 1)
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
            Text('Page $currentPage of $lastPage'),
            if (currentPage != lastPage)
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: nextPage,
              ),
          ],
        ),
      ),
    );
  }
}
