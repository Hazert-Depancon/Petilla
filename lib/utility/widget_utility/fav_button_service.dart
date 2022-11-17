import 'package:petilla_app_project/core/constant/string_constant/shared_preferences_key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavButtonService {
  Future<bool> favButton(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList(SharedPreferencesKeyConstants.favsConstant) == null) {
      return false;
    } else if (sharedPreferences.getStringList(SharedPreferencesKeyConstants.favsConstant)!.contains(docId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList(SharedPreferencesKeyConstants.favsConstant)!;
    myList.add(docId);
    await sharedPreferences.setStringList(SharedPreferencesKeyConstants.favsConstant, myList);
    return true;
  }

  Future<bool> removeFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList(SharedPreferencesKeyConstants.favsConstant)!;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] == docId) {
        myList.removeAt(i);
        break;
      }
    }
    await sharedPreferences.setStringList(SharedPreferencesKeyConstants.favsConstant, myList);
    return false;
  }

  Future<void> changeFav(docId, isFav) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList(SharedPreferencesKeyConstants.favsConstant) == null) {
      await sharedPreferences.setStringList(SharedPreferencesKeyConstants.favsConstant, []);
      addFav(docId);
    } else if (isFav == false) {
      addFav(docId);
    } else if (isFav == true) {
      removeFav(docId);
    }
  }
}
