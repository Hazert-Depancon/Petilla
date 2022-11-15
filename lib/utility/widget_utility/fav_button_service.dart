import 'package:shared_preferences/shared_preferences.dart';

class FavButtonService {
  Future<bool> favButton(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList("favs") == null) {
      return false;
    } else if (sharedPreferences.getStringList("favs")!.contains(docId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList("favs")!;
    myList.add(docId);
    await sharedPreferences.setStringList("favs", myList);
    return true;
  }

  Future<bool> removeFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList("favs")!;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] == docId) {
        myList.removeAt(i);
        break;
      }
    }
    await sharedPreferences.setStringList("favs", myList);
    return false;
  }

  Future<void> changeFav(docId, isFav) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList("favs") == null) {
      await sharedPreferences.setStringList("favs", []);
      addFav(docId);
    } else if (isFav == false) {
      addFav(docId);
    } else if (isFav == true) {
      removeFav(docId);
    }
  }
}
