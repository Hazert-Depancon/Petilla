import 'package:hive/hive.dart';

part 'hive_data.g.dart';

@HiveType(typeId: 0)
class Fav extends HiveObject {
  @HiveField(0)
  bool isFav;

  Fav({
    this.isFav = false,
  });
}
