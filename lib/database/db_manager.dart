import 'package:epsilon/model/shop.dart';
import 'package:sembast/sembast.dart';

import 'app_database.dart';

class DbManager {
  // ignore: constant_identifier_names
  static const String SHOP_STORE_NAME = 'shop';

  final _shopStore = intMapStoreFactory.store(SHOP_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;


  // Shop Management Functions

  Future insertShop(Shop shop) async {
    await _shopStore.record(shop.id).put(await _db, shop.toMap());
  }

  Future updateShop(Shop shop) async {
    final finder = Finder(filter: Filter.byKey(shop.id));
    await _shopStore.update(
      await _db,
      shop.toMap(),
      finder: finder,
    );
  }

  Future deleteShop(Shop shop) async {
    final finder = Finder(filter: Filter.byKey(shop.id));
    await _shopStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Shop>> getAllShops() async {

    final recordSnapshots = await _shopStore.find(
      await _db,
    );

    return recordSnapshots.map((snapshot) {
      return Shop.fromMap(snapshot.value);
    }).toList();
  }

  Future deleteAllShop() async {
    final finder = Finder();
    await _shopStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Shop>> getAllSortedClick() async {
    final finder = Finder(sortOrders: [
      SortOrder('nbr_clicks'),
    ]);

    final recordSnapshots = await _shopStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final shop = Shop.fromMap(snapshot.value);
      return shop;
    }).toList();
  }


  /*
  // Circuit Management Functions

  Future insertCircuit(Circuit circuit) async {
    await _circuitStore.add(await _db, circuit.toMap());
  }

  Future updateCircuit(Circuit circuit) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(circuit.circuitId));
    await _circuitStore.update(
      await _db,
      circuit.toMap(),
      finder: finder,
    );
  }

  Future deleteCircuit(Circuit circuit) async {
    final finder = Finder(filter: Filter.byKey(circuit.circuitId));
    await _circuitStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Circuit>> getAllCircuits() async {

    final recordSnapshots = await _circuitStore.find(
      await _db,
    );

    return recordSnapshots.map((snapshot) {
      final circuit = Circuit.fromMap(snapshot.value);
      circuit.key = snapshot.key;
      return circuit;
    }).toList();
  }

  // Category Management Functions

  Future insertCategory(Category category) async {
    await _categoryStore.add(await _db, category.toMap());
  }

  Future updateCategory(Category category) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(category.categoryId));
    await _categoryStore.update(
      await _db,
      category.toMap(),
      finder: finder,
    );
  }

  Future deleteCategory(Category category) async {
    final finder = Finder(filter: Filter.byKey(category.categoryId));
    await _categoryStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Category>> getAllCategories() async {
    final recordSnapshots = await _categoryStore.find(
      await _db,
    );

    return recordSnapshots.map((snapshot) {
      final category = Category.fromMap(snapshot.value);
      category.key = snapshot.key;
    }).toList();
  }

  // Event Management Functions

  Future insertEvent(Event event) async {
    await _eventStore.add(await _db, event.toMap());
  }

  Future updateEvent(Event event) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(event.id));
    await _eventStore.update(
      await _db,
      event.toMap(),
      finder: finder,
    );
  }

  Future deleteEvent(Event event) async {
    final finder = Finder(filter: Filter.byKey(event.id));
    await _eventStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Event>> getAllEvents() async {
    final recordSnapshots = await _eventStore.find(
      await _db,
    );

    return recordSnapshots.map((snapshot) {
      final event = Event.fromMap(snapshot.value);
      event.key = snapshot.key;
    }).toList();
  }

  */
}