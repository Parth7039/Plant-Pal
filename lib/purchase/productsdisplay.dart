import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medigard/purchase/productbox.dart';
class productsDisplayPage extends StatelessWidget {
  const productsDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                  ProductBox(productName: 'Blue Rose', imagePath: 'assets/images/rose3.jpg', productRate: '150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Sunflower', imagePath: 'assets/images/sunflower.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Lotus', imagePath: 'assets/images/lotus.jpg', productRate: '150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Lily', imagePath: 'assets/images/lily.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Tulip', imagePath: 'assets/images/tulip.jpg', productRate: '150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Marigold', imagePath: 'assets/images/marigold.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Daisy', imagePath: 'assets/images/daisy.jpg', productRate: '150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Hibiscus', imagePath: 'assets/images/hibiscus.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Lavender', imagePath: 'assets/images/lavender.jpg', productRate: '150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Iris', imagePath: 'assets/images/iris.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Jasmine', imagePath: 'assets/images/jasmine.jpg', productRate: '150/Kg',),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProductBox(productName: 'Orchid', imagePath: 'assets/images/orchid.jpg', productRate: '150/Kg',),
                  ProductBox(productName: 'Daffodil', imagePath: 'assets/images/daffodil.jpg', productRate: '150/Kg',),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
