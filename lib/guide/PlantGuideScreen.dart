import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'config.dart';

class PlantGuideScreen extends StatefulWidget {
  final int plantId;

  PlantGuideScreen({required this.plantId});

  @override
  _PlantGuideScreenState createState() => _PlantGuideScreenState();
}
class _PlantGuideScreenState extends State<PlantGuideScreen> {
  late Future<Map<String, dynamic>> futurePlantGuide;

  @override
  void initState() {
    super.initState();
    futurePlantGuide = fetchPlantGuide(widget.plantId.toString());
  }

  Future<Map<String, dynamic>> fetchPlantGuide(String plantId) async {
    try {
      final String url = 'https://perenual.com/api/species-care-guide-list?key=$key&id=$plantId';
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load plant guide: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error loading plant guide: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Guide'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futurePlantGuide,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final guideData = snapshot.data!['data'][0];
            final speciesId = guideData['species_id'];
            final commonName = guideData['common_name'];
            final scientificNames = guideData['scientific_name'].join(', ');
            final sections = guideData['section'];

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Text(
                  'Species ID: $speciesId',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Common Name: $commonName',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Scientific Names: $scientificNames',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                for (var section in sections)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type: ${section['type']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(section['description']),
                      SizedBox(height: 16.0),
                    ],
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
