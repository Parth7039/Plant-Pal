import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class View_GardenPage extends StatefulWidget {
  final String imageUrl;
  final String gardenName;
  final String soil_type;

  const View_GardenPage({Key? key, required this.imageUrl, required this.gardenName, required this.soil_type}) : super(key: key);

  @override
  _View_GardenPageState createState() => _View_GardenPageState();
}

class _View_GardenPageState extends State<View_GardenPage> {
  double _percent = 0.0;
  String _soilType = '';

  @override
  void initState() {
    super.initState();
    _loadPercentAndSoilTypeFromFirebase();
  }

  void _loadPercentAndSoilTypeFromFirebase() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection('percentages').doc(widget.gardenName).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data.containsKey('percent')) {
          setState(() {
            _percent = data['percent'] ?? 0.0;
          });
        } else {
          print('The document does not contain the field "percent".');
        }
      } else {
        print('The document does not exist.');
      }

      // Fetch soil type
      final gardenSnapshot = await FirebaseFirestore.instance.collection('gardens').doc(widget.gardenName).get();
      if (gardenSnapshot.exists) {
        final gardenData = gardenSnapshot.data();
        if (gardenData != null && gardenData.containsKey('soilType')) {
          setState(() {
            _soilType = gardenData['soilType'] ?? '';
          });
        } else {
          print('The document does not contain the field "soilType".');
        }
      } else {
        print('The garden document does not exist.');
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  void _updatePercentToFirebase(double percent) async {
    await FirebaseFirestore.instance.collection('percentages').doc(widget.gardenName).set({
      'percent': percent,
    }, SetOptions(merge: true));
  }

  void _increasePercent() {
    setState(() {
      _percent = (_percent + 0.01).clamp(0.0, 1.0);
      _updatePercentToFirebase(_percent);
    });
  }

  void _decreasePercent() {
    setState(() {
      _percent = (_percent - 0.01).clamp(0.0, 1.0);
      _updatePercentToFirebase(_percent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        title: const Text('My Gardens', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: Colors.black)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.imageUrl.isNotEmpty
                      ? Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  )
                      : Placeholder(),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 170,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: CircularPercentIndicator(
                            radius: 60,
                            lineWidth: 8,
                            percent: _percent,
                            progressColor: Colors.green.shade900,
                            backgroundColor: Colors.green.shade200,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.grass_rounded),
                                Text((_percent * 100).toStringAsFixed(0) + '%')
                              ],
                            ),
                            animation: true,
                            animationDuration: 800,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: _decreasePercent, icon: Icon(Icons.navigate_before)),
                            SizedBox(width: 50,),
                            IconButton(onPressed: _increasePercent, icon: Icon(Icons.navigate_next)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text('Soil Type: $_soilType'),
          ],
        ),
      ),
    );
  }
}
