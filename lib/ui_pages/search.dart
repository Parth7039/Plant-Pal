import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';

class Plant {
  final String name;
  final String imageUrl;
  final String plantFamily;
  final String soilType;
  final String Observe;

  Plant({
    required this.name,
    required this.imageUrl,
    required this.plantFamily,
    required this.soilType,
    required this.Observe,
  });
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Search',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PlantSearchPage(),
    );
  }
}

class PlantSearchPage extends StatefulWidget {
  @override
  _PlantSearchPageState createState() => _PlantSearchPageState();
}

class _PlantSearchPageState extends State<PlantSearchPage> {
  int selected_index = 0;
  TextEditingController _searchController = TextEditingController();
  List<Plant> _plants = [];

  Future<void> _searchPlants(String query) async {
    final String apiKey = 'kHYYam9h9OOHRjQ7tvQcVZSzqMMIUPHH6RY9PEqS9vQ';
    final String apiUrl =
        'https://trefle.io/api/v1/plants/search?token=$apiKey&q=$query';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> plantsJson = data['data'];

      setState(() {
        _plants.clear();
        _plants.addAll(plantsJson.map((plantJson) => Plant(
          name: plantJson['common_name'] ?? '',
          imageUrl: plantJson['image_url'] ?? '',
          plantFamily: plantJson['family'] ?? '',
          soilType: plantJson['growth_form'] ?? '',
          Observe: plantJson['observations'] ?? '',
        )).toList());
      });
    } else {
      throw Exception('Failed to load plants');
    }
  }

  void _showPlantDetails(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantDetailsPage(plant: plant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)
                ),
                labelText: 'Search Plants',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Search Plants here!!',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      _searchPlants(query);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _plants.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2,color: Colors.blue),
                      borderRadius: BorderRadius.circular(11)
                    ),
                    child: ListTile(
                      title: Text(_plants[index].name),
                      leading: _plants[index].imageUrl.isNotEmpty
                          ? Image.network(_plants[index].imageUrl)
                          : Placeholder(),
                      onTap: () {
                        _showPlantDetails(_plants[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlantDetailsPage extends StatelessWidget {
  final Plant plant;

  PlantDetailsPage({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: ${plant.name}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                plant.imageUrl.isNotEmpty
                    ? Image.network(plant.imageUrl)
                    : Placeholder(),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Plant Family: ${plant.plantFamily}',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(Icons.info),
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Soil suitability: ${plant.soilType}',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(Icons.info),
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Observations:  ${plant.Observe}',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(Icons.info),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
