import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/apps/pet_form/pet_form_view/main_pet_form_view/groups/cat_group_chat.dart';
import 'package:petilla_app_project/apps/pet_form/pet_form_view/main_pet_form_view/groups/dog_grop_chat_view.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:quickalert/quickalert.dart';

class PetformHomeView extends StatelessWidget {
  const PetformHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bir grup seç'),
        foregroundColor: LightThemeColors.miamiMarmalade,
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
          ListTile(
            title: const Text("Kedi"),
            leading: SvgPicture.asset("assets/svg/cat.svg", height: 32),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CatGroupChat()));
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
        _awesomeDialog(context);
      },
      child: const Icon(Icons.group_add_outlined),
    );
  }

  _awesomeDialog(BuildContext context) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Hata',
      text: 'Henüz Grup Oluşturma Özelliği Aktif Değil',
      confirmBtnText: 'Tamam',
      confirmBtnColor: Colors.red,
    );
  }
}
