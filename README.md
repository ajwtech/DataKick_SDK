# DataKick SDK
SDK to interface with datakick.com

There are 3 constructors

```dart
///Default product
product();
///empty product
product.empty();
///product with just the food parameters
product.food();
```

Getting, setting and updating product info is easy

```dart
///create an object
Product product = new Product.empty();

/// Then pass a barcode to the object and wait for the future
product.getBarcode("00000000000000").then((product) {
    ///Now you can work with your product here...

    // change the name of the product
    product.name = "new name";
    product.update();
}

```
You can store a list of products in a productmap object as well.
```dart ///Datakick will retrieve 100 products at a time.
dataKickList(dkl).then(expectAsync1((ProductMap pro3) {
  ///Calling
  dataKickList(pro3).then(expectAsync1((ProductMap pro4) {
    expect(pro3.resp.statusCode, 200);
  }));
}));
```

Currently Images are not properly handled in updates. 