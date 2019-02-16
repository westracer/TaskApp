import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kurs/types/app/user.dart';
import 'package:ui_kurs/widgets/models/app-state.dart';
import 'package:ui_kurs/widgets/ui/drawer/generate-tile.dart';
import 'package:ui_kurs/widgets/ui/drawer/initial-state-tile.dart';
import 'package:ui_kurs/widgets/ui/drawer/load-tile.dart';
import 'package:ui_kurs/widgets/ui/drawer/save-tile.dart';
import 'package:ui_kurs/widgets/ui/drawer/signout-tile.dart';

class CustomDrawer extends StatelessWidget {
  Widget _header(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state, 
        builder: (context, state) {
          final User currentUser = state.currentUser;
          if (currentUser == null) {
            return Text('Вы не авторизованы');
          }

          final Widget userName = Text(
            currentUser.name, 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          );
          final Widget userEmail = Text(
            currentUser.email, 
            style: TextStyle(color: Colors.white)
          );

          return Column(
            children: <Widget>[
              userName,
              userEmail,
            ],
          );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: _header(context),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            LoadTile(),
            SaveTile(),
            GenerateTile(),
            InitialStateTile(),
            SignOutTile(),
          ],
        ),
      );
  }
}