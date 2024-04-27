import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medigard/purchase/cart.dart';
import 'package:medigard/purchase/productbox.dart';
import 'package:medigard/ui_pages/homepage.dart';
class flowerDisplayPage extends StatelessWidget {
  const flowerDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
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
                            child: Image.asset('assets/images/wallpaper.jpg',fit: BoxFit.cover,))),
                    Text('Flowers',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Rose', imagePath: 'assets/images/rose.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Blue Rose', imagePath: 'assets/images/rose3.jpg', productRate: '260/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Sunflower', imagePath: 'assets/images/sunflower.jpg', productRate: '110/Kg',),
                  ProductBox(productName: 'Lotus', imagePath: 'assets/images/lotus.jpg', productRate: '160/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Lily', imagePath: 'assets/images/lily.jpg', productRate: '300/Kg',),
                  ProductBox(productName: 'Tulip', imagePath: 'assets/images/tulip.jpg', productRate: '450/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Marigold', imagePath: 'assets/images/marigold.jpg', productRate: '360/Kg',),
                  ProductBox(productName: 'Daisy', imagePath: 'assets/images/daisy.jpg', productRate: '250/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Hibiscus', imagePath: 'assets/images/hibiscus.jpg', productRate: '350/Kg',),
                  ProductBox(productName: 'Lavender', imagePath: 'assets/images/lavender.jpg', productRate: '160/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Iris', imagePath: 'assets/images/iris.jpg', productRate: '500/Kg',),
                  ProductBox(productName: 'Jasmine', imagePath: 'assets/images/jasmine.jpg', productRate: '160/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Orchid', imagePath: 'assets/images/orchid.jpg', productRate: '900/Kg',),
                  ProductBox(productName: 'Daffodil', imagePath: 'assets/images/daffodil.jpg', productRate: '500/Kg',),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
