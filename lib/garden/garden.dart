import 'package:flutter/material.dart';
import 'package:medigard/garden/garden_dialog.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../ui_pages/homepage.dart';
import 'garden_tile.dart';
class Garden_displayPage extends StatefulWidget {
  const Garden_displayPage({super.key});

  @override
  State<Garden_displayPage> createState() => _Garden_displayPageState();
}

class _Garden_displayPageState extends State<Garden_displayPage> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return GardenTile();
  }
}
