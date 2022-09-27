import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/apps/pet_form/pet_form_view/main_pet_form_view/group_template.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
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
            title: const Text("Genel Sohbet"),
            leading: const Icon(
              Icons.language,
              size: 32,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupChat(
                    collectionId: "general_messages",
                    docId: "general_chat",
                    pageTitle: "Genel Sohbet",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Köpek"),
            leading: SvgPicture.asset("assets/svg/dog.svg", height: 36),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupChat(
                    collectionId: "dog_messages",
                    docId: "dog_chat",
                    pageTitle: "Köpek Sohbeti",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Kedi"),
            leading: SvgPicture.asset("assets/svg/cat.svg", height: 32),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupChat(
                    collectionId: "cat_messages",
                    docId: "dog_chat",
                    pageTitle: "Kedi Sohbeti",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Tavşan"),
            leading: SvgPicture.asset("assets/svg/rabbit.svg", height: 32),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupChat(
                    collectionId: "rabbit_messages",
                    docId: "rabbit_chat",
                    pageTitle: "Tavşan Sohbeti",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Balık"),
            leading: SvgPicture.asset("assets/svg/fish.svg", height: 32),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupChat(
                    collectionId: "balik_messages",
                    docId: "balik_chat",
                    pageTitle: "Balık Sohbeti",
                  ),
                ),
              );
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
