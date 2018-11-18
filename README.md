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
```dart
///Datakick will retrieve 100 products at a time.
dataKickList(dkl).then(expectAsync1((ProductMap pro3) {
  ///Calling this recursively will grow the list by 100
  ///products at a time.
  dataKickList(pro3).then(expectAsync1((ProductMap pro4) {
    /// list would now have 200 entries.
  }));
}));
```

package Road map:
* Initial commit contains just enough to:
    * Get by barcode
    * Update products
    * create products
    * list products (100 at a time. Resubmit the product back to the list function to grow it by the next 100 products)

*TODO*:
* Add functionality for camera plugin to create a widget (v0.3.0)
* Add functionality for adding (v1.0.0)
* Add functionality for updating or modifying images (version undetermined)
* Add functionality for image removal (version undetermined)
* Add functionality for image data parsing through ML/AI (v2.0.0)
