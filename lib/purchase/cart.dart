import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medigard/purchase/soils.dart';
import '../ui_pages/homepage.dart';
import 'equipments.dart';
import 'flowers.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        title: const Text('Shopify', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImage('assets/images/hello.jpg', flowerDisplayPage()),
              _buildImage('assets/images/hello2.jpg', SoilsPage()),
              _buildImage('assets/images/hello3.jpg', equipmentPage()),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 35),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Flowers'),
              ),
              SizedBox(width: 65),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Soils'),
              ),
              SizedBox(width: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Equipments'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Cart', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  color: Colors.green[300], // Add color to see the container
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath, Widget destinationWidget) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destinationWidget));
        },
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(imagePath, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
