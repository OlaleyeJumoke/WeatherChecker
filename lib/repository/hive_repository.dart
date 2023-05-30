import 'package:hive/hive.dart';
import 'package:weather_check/repository/hive_interface.dart';

import '../utils/constants.dart';

class HiveRepositoryImplementation implements HiveRepository {
  HiveRepositoryImplementation();
  @override
  openHives(List<String> boxNames) async {
    var boxHives = boxNames.map((name) => Hive.openBox(name));
    printOnlyInDebug("trying to open hive boxes");
    await Future.wait(boxHives);
    printOnlyInDebug("Hive boxes opened");
  }

  @override
  add<T>({T? item, String? key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    box.put(key, item);
  }

  @override
  T get<T>({required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.get(key);
  }

  @override
  remove<T>({required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.delete(key);
  }

  checkBoxState(box) {
    if (box == null) throw Exception('Box has not been set');
  }

  @override
  clear<T>({required String name}) async {
    var box = Hive.box(name);
    checkBoxState(box);
    await box.clear();
  }
}
