import 'package:ecommereceshop/application/product/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/product/interface_product.dart';
import '../../service/product_service.dart';

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) =>
        ProductNotifier(
            ProductState(isLoad: false, errorMessage: '', isSuccess: false),
            ref.watch(proServiceProvider)));

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductInterface productInterface;
  ProductNotifier(super.state, this.productInterface);

  Future<void> productAdd(
      {required String product_name,
      required String product_detail,
      required int price,
      required XFile image}) async {
    state = state.copyWith(errorMessage: '', isLoad: true, isSuccess: false);
    final response = await productInterface.productAdd(
        product_name: product_name,
        product_detail: product_detail,
        price: price,
        image: image);
    response.fold(
        (l) => state = state.copyWith(errorMessage: l, isLoad: false),
        (r) => state =
            state.copyWith(errorMessage: '', isLoad: false, isSuccess: true));
  }

  Future<void> productUpdate(
      {required String product_name,
      required String product_detail,
      required int price,
      XFile? image,
      String? imageId,
      required String productId}) async {
    state = state.copyWith(errorMessage: '', isLoad: true, isSuccess: false);
    final response = await productInterface.productUpdate(
        product_name: product_name,
        product_detail: product_detail,
        price: price,
        productId: productId,
        image: image,
        imageId: imageId);
    response.fold(
        (l) => state = state.copyWith(errorMessage: l, isLoad: false),
        (r) => state =
            state.copyWith(errorMessage: '', isLoad: false, isSuccess: true));
  }

  Future<void> productRemove(
      {required String productId, required String imageId}) async {
    state = state.copyWith(errorMessage: '', isLoad: true, isSuccess: false);
    final response = await productInterface.productRemove(
        productId: productId, imageId: imageId);
    response.fold(
        (l) => state = state.copyWith(errorMessage: l, isLoad: false),
        (r) => state =
            state.copyWith(errorMessage: '', isLoad: false, isSuccess: true));
  }
}
