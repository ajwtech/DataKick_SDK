import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:datakick_sdk/datakick_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Added for barcode scanning
//Package to be added


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DATAKICK SDK EXAMPLE',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: BarcodeScan(),
    );
  }
}

class BarcodeScan extends StatefulWidget {
  @override
  BarcodeScannerState createState() => new BarcodeScannerState();
}

class BarcodeScannerState extends State<BarcodeScan> {
  String barcode = "";
  String dataKick = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Add to inventory'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new MaterialButton(
                    onPressed: scan, child: new Text("Scan")),
                padding: const EdgeInsets.all(8.0),
              ),
              new Text(dataKick),
              new Text(barcode)
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
    //lookup barcode
    Product product = new Product.empty();
    product.getBarcode(this.barcode).then((product) {
      setState(() => dataKick = product.brand_name.toString());
    });
  }
}
