// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class IlSecimiSayfasi extends StatelessWidget {
  final List ilIsimleri;

  const IlSecimiSayfasi({Key? key, required this.ilIsimleri}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: ilIsimleri.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    ilIsimleri[index],
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
