import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavButtonService {
  Future<bool> favButton(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList(SharedKeys.FAVS.toString()) == null) {
      return false;
    } else if (sharedPreferences.getStringList(SharedKeys.FAVS.toString())!.contains(docId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList(SharedKeys.FAVS.toString())!;
    myList.add(docId);
    await sharedPreferences.setStringList(SharedKeys.FAVS.toString(), myList);
    return true;
  }

  Future<bool> removeFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList(SharedKeys.FAVS.toString())!;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] == docId) {
        myList.removeAt(i);
        break;
      }
    }
    await sharedPreferences.setStringList(SharedKeys.FAVS.toString(), myList);
    return false;
  }

  Future<void> changeFav(docId, isFav) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList(SharedKeys.FAVS.toString()) == null) {
      await sharedPreferences.setStringList(SharedKeys.FAVS.toString(), []);
      addFav(docId);
    } else if (isFav == false) {
      addFav(docId);
    } else if (isFav == true) {
      removeFav(docId);
    }
  }
}
