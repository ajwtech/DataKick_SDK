library datakick_sdk;

import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart' as cam;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'datakick_sdk.g.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  cam.CameraController controller;

  @override
  void initState() {
    super.initState();

    controller =
        new cam.CameraController(getCameras()[0], cam.ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  getCameras() async {
    var cameras = await cam.availableCameras();
    return cameras;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: new cam.CameraPreview(controller));
  }
}
// ignore: non_constant_identifier_names
@JsonSerializable()
class Product {
  // watch this with flutter packages pub run build_runner watch
  // publish with flutter packages pub publish
// ignore: non_constant_identifier_names
  String gtin14, brand_name,
      name,
      size,
      ingredients,
  // ignore: non_constant_identifier_names
      serving_size,
  // ignore: non_constant_identifier_names
      servings_per_container;
  double calories,
  // ignore: non_constant_identifier_names
      fat_calories,
      fat,
  // ignore: non_constant_identifier_names
      saturated_fat,
  // ignore: non_constant_identifier_names
      trans_fat,
  // ignore: non_constant_identifier_names
      polyunsaturated_fat;

  // ignore: non_constant_identifier_names
  double monounsaturated_fat, cholesterol, sodium, potassium, carbohydrate;
  double fiber, sugars, protein,
  // ignore: non_constant_identifier_names
      alcohol_by_volume;
  String author, format, publisher;
  int pages;
  var images;

  Product(this.gtin14,
      this.brand_name,
      this.name,
      this.size,
      this.ingredients,
      this.serving_size,
      this.servings_per_container,
      this.calories,
      this.fat_calories,
      this.fat,
      this.saturated_fat,
      this.trans_fat,
      this.polyunsaturated_fat,
      this.monounsaturated_fat,
      this.cholesterol,
      this.sodium,
      this.potassium,
      this.carbohydrate,
      this.fiber,
      this.sugars,
      this.protein,
      this.images,
      this.author,
      this.format,
      this.publisher,
      this.pages,
      this.alcohol_by_volume);

  Product.food(this.gtin14,
      this.brand_name,
      this.name,
      this.size,
      this.ingredients,
      this.serving_size,
      this.servings_per_container,
      this.calories,
      this.fat_calories,
      this.fat,
      this.saturated_fat,
      this.trans_fat,
      this.polyunsaturated_fat,
      this.monounsaturated_fat,
      this.cholesterol,
      this.sodium,
      this.potassium,
      this.carbohydrate,
      this.fiber,
      this.sugars,
      this.protein,
      this.alcohol_by_volume);

  Product.empty();

  /// A necessary factory constructor for creating a new instance
  /// from a map. Pass the map to the generated `_$ProductFromJson` constructor.
  /// The constructor is named after the source class, in this case Product.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$FoodToJson`.
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  _getBarcodeData(String barcode) async {
    //lookup barcode
    String uri = "https://www.datakick.org/api/items/" + barcode;
    final http.Response _resp = await http.get(uri);
    return _resp;
  }

  Future<Product> getBarcode(String barcode) async {
    var resp = await _getBarcodeData(barcode);
    Map productMap = json.decode(resp.body);
    var product = new Product.fromJson(productMap);
    return product;
  }

  _sendBarcodeData(String barcode) async {
    //lookup barcode
    String uri = "https://www.datakick.org/api/items/" + barcode;
    var body = json.encode(this);
    Map<String, String> headers = {"Content-Type": "application/json"};
    http.Response resp = await http.put(uri, headers: headers, body: body);
    return resp;
  }

  Future<Product> update() async {
    var resp = await this._sendBarcodeData(this.gtin14);

    Map productMap = json.decode(resp.body);
    var product = new Product.fromJson(productMap);
    return product;
  }
}

_dataKicklist({String uri = "https://www.datakick.org/api/items/"}) async {
  //lookup barcode

  final http.Response _resp = await http.get(uri);
  return _resp;
}

Future<ProductMap> dataKickList(ProductMap productMap) async {
  http.Response resp;
  if (productMap.resp != null) {
    String link = productMap.resp.headers['link'];
    var start = link.indexOf("<") + 1;
    var end = link.indexOf(">");
    link = link.substring(start, end);
    resp = await _dataKicklist(uri: link);
  } else {
    resp = await _dataKicklist();
  }
  var prods = json.decode(resp.body);
  productMap.products.insertAll(productMap.products.length, prods);
//  productMap.products.addAll(prods);
  productMap.resp = resp;
  return productMap;
}

class ProductMap {
  http.Response resp;
  List<dynamic> products = [];
}
