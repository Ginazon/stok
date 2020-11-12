import 'package:flutter/material.dart';
import 'package:stok/app/stok_ekle.dart';

class PlasmaList extends StatefulWidget {
  @override
  _PlasmaListState createState() => _PlasmaListState();
}

class _PlasmaListState extends State<PlasmaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plasma"),
      ),
      body: Center(
        child: Text("Plasma Listesi "),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          heroTag: 2,
          child: Icon(
            Icons.add_circle_outline,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => StokEkle(),
              ),
            );
          },
        ),
      ),
    );
  }
}
