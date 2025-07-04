import 'package:flutter/material.dart';
import 'package:medigard/purchase/soils.dart';
import 'package:slide_to_act/slide_to_act.dart';
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
      backgroundColor: Colors.green.shade500,
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
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text('Rose',style: TextStyle(fontSize: 20),),
                      subtitle: Text('150/Kg'),
                      trailing: Text('Rs.450'),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.white,
                      title: Text('Lotus',style: TextStyle(fontSize: 20),),
                      subtitle: Text('160/Kg'),
                      trailing: Text('Rs.320'),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.white,
                      title: Text('Tulip',style: TextStyle(fontSize: 20),),
                      subtitle: Text('450/Kg'),
                      trailing: Text('Rs.450'),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.white,
                      title: Text('Daisy',style: TextStyle(fontSize: 20),),
                      subtitle: Text('250/Kg'),
                      trailing: Text('Rs.500'),
                    ),
                  ),
                  SizedBox(height: 180,),
                  SlideAction(
                    sliderButtonIcon: Icon(Icons.paypal),
                    text: 'Slide to pay',
                    sliderRotate: false,
                    elevation: 5,
                    innerColor: Colors.white,
                    outerColor: Colors.black,
                    submittedIcon: Icon(Icons.done_all,color: Colors.white,),
                    animationDuration: Duration(milliseconds: 450),
                    onSubmit: (){},
                  ),
                ],
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
