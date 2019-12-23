import 'package:epsilon/model/category.dart';
import 'package:epsilon/model/shop.dart';

class Filter {
  List<Shop> filterByCategory(
      List<Shop> shops, List<Shop> toList, Category category) {
    List<Shop> filteredList = [];
    for (int i = 0; i < shops.length; i++) {
      if (!toList.contains(shops[i])) {
        for (int j = 0; j < shops[i].categories.length; j++) {
          if (shops[i].categories[j].id == category.id) {
            filteredList.add(shops[i]);
            j = shops[i].categories.length;
          }
        }
      }
    }
    return filteredList;
  }

  List<Shop> filterByCharacters(
      List<Shop> shops, String input) {
    List<Shop> filteredList = [];
    int access;
    for (int i = 0; i < shops.length; i++) {
      access = 1;
      for (int j = 0; j < input.length; j++) {
        if (shops[i].title[j].toLowerCase() != input[j].toLowerCase())
          access = 0;
      }
      if (access == 1)
        filteredList.add(shops[i]);
    }
    return filteredList;
  }
}
