import 'package:dartz/dartz.dart';
import 'package:ecommereceshop/domain/product/product.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProductInterface {
  Future<Either<String, bool>> productAdd({
    required String product_name,
    required String product_detail,
    required int price,
    required XFile image,
  });
  Future<List<Product>> getData();

  Future<Either<String, bool>> productUpdate(
      {required String product_name,
      required String product_detail,
      required int price,
      required String productId,
      XFile? image,
      String? imageId});

  Future<Either<String, bool>> productRemove(
      {required String productId, required String imageId});
}
