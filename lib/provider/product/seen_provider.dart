import 'dart:convert';
import 'dart:core';
import 'package:ann_shop_flutter/core/storage_manager.dart';
import 'package:ann_shop_flutter/core/utility.dart';
import 'package:ann_shop_flutter/model/product/product.dart';
import 'package:flutter/material.dart';

class SeenProvider with ChangeNotifier {
  final String _keyLocaleSeenProduct = '_keyLocaleSeenProduct';
  List<Product> products;
  final int maxItem = 20;
  SeenProvider() {
    loadListProduct();
  }

  loadListProduct() async {
    try {
      /// shopping
      String response = await StorageManager.getObjectByKey(_keyLocaleSeenProduct);
      if (response == null || response.isEmpty) {
        products = new List();
      } else {
        var message = json.decode(response);
        var list = message as List;
        products = list.map((item) => Product.fromJson(item)).toList();
      }
    } catch (e) {
      products = new List();
    }
  }

  saveListProduct() {
    var myJsonString =
    json.encode(products.map((value) => value.toJson()).toList());
    StorageManager.setObject(_keyLocaleSeenProduct, myJsonString);
  }

  addNewProduct(Product item) {
    List<Product> array =
    products.where((product) => product.productID == item.productID).toList();
    if (Utility.isNullOrEmpty(array)) {
      products.insert(0, item);
    }else{
      products.remove(item);
      products.insert(0, item);
    }
    if(products.length > maxItem){
      products.removeLast();
    }
    saveListProduct();
    notifyListeners();
    print('Add seen productID ${item.productID}');
  }

  removeAllProductProvider() {
    products = new List();
    saveListProduct();
    notifyListeners();
  }

  removeProduct(int productID) {
    products.removeWhere((p) => p.productID == productID);
    saveListProduct();
    notifyListeners();
    print('Remove seen productID $productID');
  }
}