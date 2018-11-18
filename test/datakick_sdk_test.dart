import 'package:datakick_sdk/datakick_sdk.dart';
import 'package:test/test.dart';

void main() {
  test('get a product from the database', () {
    Product prod = new Product.empty();
    prod.getBarcode("074401704416").then(expectAsync1((Product pro) {
      expect(pro.brand_name, "Riviana");
      expect(pro.name, "Orzo 100% Whole Wheat Pasta");
    }));
  });

  test('put (create or update) a product from the database', () {
    Product prod = new Product.empty();
    prod.getBarcode("074401704416").then(expectAsync1((Product pro) {
      expect(pro.brand_name, "Riviana");
      expect(pro.name, "Orzo 100% Whole Wheat Pasta");
      pro.name = "Orzo 100 Percent Whole Wheat Pasta";
      pro.update().then(expectAsync1((Product pro1) {
        expect(pro1.brand_name, "Riviana");
        expect(pro1.name, "Orzo 100 Percent Whole Wheat Pasta");
        pro1.name = "Orzo 100% Whole Wheat Pasta";
        pro1.update().then(expectAsync1((Product pro2) {
          expect(pro2.brand_name, "Riviana");
          expect(pro2.name, "Orzo 100% Whole Wheat Pasta");
        }));
      }));
    }));
  });
  test('list stuff', () {
    ProductMap dkl = new ProductMap();
    dataKickList(dkl).then(expectAsync1((ProductMap pro3) {
      expect(pro3.resp.statusCode, 200);
      dataKickList(pro3).then(expectAsync1((ProductMap pro4) {
        expect(pro3.resp.statusCode, 200);
      }));
    }));
  });
}
