import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kurs/widgets/ui/drawer/generate-tile.dart';
import 'package:ui_kurs/widgets/ui/drawer/load-tile.dart';
import 'package:ui_kurs/widgets/ui/drawer/save-tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            LoadTile(),
            SaveTile(),
            GenerateTile(),
          ],
        ),
      );
  }
}