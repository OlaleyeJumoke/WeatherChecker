abstract class HiveRepository {
  openHives(List<String> boxNames);
  add<T>({T item, String key, required String name});
  T get<T>({required String key, required String name});
  remove<T>({required String key, required String name});
  clear<T>({required String name});
}
