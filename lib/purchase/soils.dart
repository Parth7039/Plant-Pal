import 'package:flutter/material.dart';

import 'cart.dart';

class SoilsPage extends StatelessWidget {
  const SoilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));},
        )
      ),
    );
  }
}
