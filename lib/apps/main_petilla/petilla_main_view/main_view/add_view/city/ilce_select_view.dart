// ignore_for_file: library_private_types_in_public_api, no_logic_in_create_state

import 'package:flutter/material.dart';

class IlceSecmeSayfasi extends StatefulWidget {
  final List ilceIsimleri;

  const IlceSecmeSayfasi({Key? key, required this.ilceIsimleri}) : super(key: key);
  @override
  _IlceSecmeSayfasiState createState() => _IlceSecmeSayfasiState(ilceIsimleri);
}

class _IlceSecmeSayfasiState extends State<IlceSecmeSayfasi> {
  final List ilceIsimleri;

  _IlceSecmeSayfasiState(this.ilceIsimleri);

  @override
  void initState() {
    super.initState();
    ilceIsimleri.sort((a, b) => a.toString().compareTo(b.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.ilceIsimleri.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                widget.ilceIsimleri[index],
              ),
              onTap: () {
                Navigator.pop(context, index);
              },
            );
          }),
    );
  }
}
