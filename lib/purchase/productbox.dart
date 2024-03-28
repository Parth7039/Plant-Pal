import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProductBox extends StatelessWidget {
  final String productName;
  final String imagePath;
  final String productRate;

  const ProductBox({
    Key? key,
    required this.productName,
    required this.imagePath,
    required this.productRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 180,
              width: 170,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(imagePath,fit: BoxFit.cover,)),
            ),
          ),
          Text(productName,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
          Text(productRate,style: TextStyle(fontSize: 15,color: Colors.white),)
        ],
      ),
    );
  }
}
