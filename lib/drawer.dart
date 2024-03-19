import 'package:flutter/material.dart';
import 'package:medigard/chats/users.dart';
import 'package:medigard/my_list_tile.dart';
import 'package:medigard/ui_pages/profile.dart';
import 'package:medigard/ui_pages/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.person,
          color: Colors.white,
            size: 64,
          )),
          MyListTile(icon:Icons.person_add, text: 'P R O F I L E', onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()),);}),
          MyListTile(icon:Icons.settings, text: 'S E T T I N G S', onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingsPage()),);}),
          MyListTile(icon:Icons.chat_outlined, text: 'C O M M U N I T Y', onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatUsers()),);}),
        ],
      ),
    );
  }
}
