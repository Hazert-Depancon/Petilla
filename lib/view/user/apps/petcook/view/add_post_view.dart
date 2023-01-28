import 'package:flutter/material.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Fotoğraf Paylaş",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
