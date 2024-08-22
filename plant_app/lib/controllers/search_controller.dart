import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/plant_model.dart';
import 'plant_controller.dart';

class SearchController1 extends GetxController {
  final searchController = TextEditingController();
  var searchResult = <PlantModel>[].obs;

  void searchPlants(String query) {
    searchResult.value = Get.find<PlantController>().plants.where((plant) {
      return plant.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}