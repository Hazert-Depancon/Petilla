// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class IlSecimiSayfasi extends StatefulWidget {
  final List ilIsimleri;

  const IlSecimiSayfasi({Key? key, required this.ilIsimleri}) : super(key: key);
  @override
  _IlSecimiSayfasiState createState() => _IlSecimiSayfasiState();
}

class _IlSecimiSayfasiState extends State<IlSecimiSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.ilIsimleri.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    widget.ilIsimleri[index],
                  ),
                  onTap: () {
                    Navigator.pop(context, index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
