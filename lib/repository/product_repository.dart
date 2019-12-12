import 'dart:convert';
import 'dart:io';

import 'package:ann_shop_flutter/provider/utility/config_provider.dart';
import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/model/product/product.dart';
import 'package:ann_shop_flutter/model/product/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  static final ProductRepository instance = ProductRepository._internal();

  factory ProductRepository() => instance;

  ProductRepository._internal() {
    /// init
    productSorts = [
      ProductSort(id: 1, title: 'Mới nhập kho'),
      ProductSort(id: 2, title: 'Giá tăng dần'),
      ProductSort(id: 3, title: 'Giá giảm dần'),
      ProductSort(id: 4, title: 'Mẫu mới nhất'),
    ];

    _productColors = {
      10: Colors.black,
      23: Colors.red[800],//Đỏ đô
      32: Colors.deepOrangeAccent[100],//Hồng cam
      38: Colors.orangeAccent[100],//Hồng phấn
      51: Colors.brown,//Kem đậm
      52: Colors.deepOrangeAccent[100],//Kem nhạt
      88: Colors.yellow,
      96: Colors.blueGrey[100],//Vỏ đậu
      108: Colors.grey,//Xám tiêu
      123: Colors.blueGrey,//Xanh đen
      128: Colors.green,//Xanh lá
      132: Colors.cyan,//Xanh lông công
    };
  }

  List<ProductSort> productSorts;
  Map<int, Color> _productColors;
  Color getColorByID(id){
    return _productColors[id]??Colors.red;
  }

  /// http://xuongann.com/api/v1/home/category/vay-dam?pageSize=8
  Future<List<Product>> loadByHomeCategory(String name, {pageSize = 8}) async {
    try {
      final url = Core.domainAPI + 'home/category/' + name + '?pageSize=$pageSize';
      final response = await http.get(url).timeout(Duration(seconds: 10));
      if (response.statusCode == HttpStatus.ok) {
        var message = jsonDecode(response.body);
        List<Product> _data = new List();
        message.forEach((v) {
          _data.add(new Product.fromJson(v));
        });
        return _data;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  /// http://xuongann.com/api/v1/category/quan-ao-nam/product?pageNumber=1&pageSize=28&sort=4
  Future<List<Product>> loadByCategory(String name,
      {page = 1, pageSize = 10, sort = 4}) async {
    try {
      final url = Core.domainAPI +
          'category/$name?pageNumber=$page&pageSize=$pageSize&sort=$sort';
      final response = await http.get(url).timeout(Duration(seconds: 10));
      print(url);
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var message = jsonDecode(response.body);
        List<Product> _data = new List();
        message.forEach((v) {
          _data.add(new Product.fromJson(v));
        });
        return _data;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<ProductDetail> loadProductDetail(String slug) async {
    try {
      final url = Core.domainAPI + 'product/' + slug;
      final response = await http.get(url).timeout(Duration(seconds: 10));
      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var message = jsonDecode(response.body);
        return ProductDetail.fromJson(message);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  log(object) {
    print('product_repository: ' + object.toString());
  }
}
