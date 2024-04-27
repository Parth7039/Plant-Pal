import 'package:flutter/material.dart';
import 'package:medigard/purchase/productbox.dart';

import 'cart.dart';

class equipmentPage extends StatelessWidget {
  const equipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
                            child: Image.asset('assets/images/hello3.jpg',fit: BoxFit.cover,))),
                    Text('Equipments',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Axe', imagePath: 'assets/equipments/axe.jpg', productRate: 'Rs.650',),
                  ProductBox(productName: 'Garbage Bin', imagePath: 'assets/equipments/bin.jpg', productRate: '150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Fence', imagePath: 'assets/equipments/fence.jpg', productRate: 'Rs.900/m',),
                  ProductBox(productName: 'Land Mower', imagePath: 'assets/equipments/mower.jpg', productRate: 'Rs.5999',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Flower Pot', imagePath: 'assets/equipments/pot.jpg', productRate: 'Rs.110',),
                  ProductBox(productName: 'Garden Rake', imagePath: 'assets/equipments/rake.jpg', productRate: 'Rs.390',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Trowel', imagePath: 'assets/equipments/trowel.jpg', productRate: 'Rs.450',),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
