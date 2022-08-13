import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/apps/pet_form/pet_form_view/main_pet_form_view/grop_chat_view.dart';

class PetformHomeView extends StatelessWidget {
  const PetformHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bir grup seç'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Köpek"),
            leading: SvgPicture.asset("assets/svg/dog.svg", height: 36),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DogGroupChat()));
            },
          ),
        ],
      ),
      floatingActionButton: _addGroup(context),
    );
  }

  FloatingActionButton _addGroup(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _awesomeDialog(context).show();
      },
      child: const Icon(Icons.group_add_outlined),
    );
  }

  AwesomeDialog _awesomeDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Hata',
      desc: 'Henüz Grup Oluşturma Özelliği Aktif Değil',
      btnCancelOnPress: () {},
      btnCancelText: "Tamam",
      btnCancelColor: Colors.blue,
    );
  }
}
