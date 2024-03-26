import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'garden.dart';

class View_GardenPage extends StatefulWidget {
  final String imageUrl;
  final double initialPercent;

  const View_GardenPage({Key? key, required this.imageUrl, required this.initialPercent}) : super(key: key);

  @override
  _View_GardenPageState createState() => _View_GardenPageState();
}

class _View_GardenPageState extends State<View_GardenPage> {
  late double _percent;

  @override
  void initState() {
    super.initState();
    _percent = widget.initialPercent;
  }

  void _increasePercent() {
    setState(() {
      _percent = (_percent + 0.1).clamp(0.0, 1.0); // Clamping between 0.0 and 1.0
    });
  }

  void _decreasePercent() {
    setState(() {
      _percent = (_percent - 0.1).clamp(0.0, 1.0); // Clamping between 0.0 and 1.0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Garden_displayPage()),
            );
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
                    border: Border.all(width: 3,color: Colors.black)
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
                          border: Border.all(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.circular(15)
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
                                  Text(_percent.toString())
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
                      )
                  ),
                  Container(
                    width: 170,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
