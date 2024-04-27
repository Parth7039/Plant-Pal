import 'package:flutter/material.dart';
import 'package:medigard/purchase/productbox.dart';

import 'cart.dart';

class SoilsPage extends StatelessWidget {
  const SoilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        title: const Text('Shopify', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        height: 200,
                        width: 370,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/images/soil.jpg',fit: BoxFit.cover,))),
                    Text('Soils',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Chalky Soil', imagePath: 'assets/soils/chalky.jpg', productRate: 'Rs.200/KG',),
                  ProductBox(productName: 'Clay Soil', imagePath: 'assets/soils/clay.jpg', productRate: 'Rs.150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Loamy Soil', imagePath: 'assets/soils/loamy.jpg', productRate: '130/Kg',),
                  ProductBox(productName: 'Peaty Soil', imagePath: 'assets/soils/peaty.jpg', productRate: '220/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Sandy Soil', imagePath: 'assets/soils/sandy.jpg', productRate: '110/Kg',),
                  ProductBox(productName: 'Silty Soil', imagePath: 'assets/soils/silty.jpg', productRate: '160/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Marigold', imagePath: 'assets/images/marigold.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Daisy', imagePath: 'assets/images/daisy.jpg', productRate: '150/Kg',),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
