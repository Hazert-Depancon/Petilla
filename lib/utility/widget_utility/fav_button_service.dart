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
}
