import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../domain/product/interface_product.dart';
import '../domain/product/product.dart';
import '../domain/user/user.dart';
import '../provider/dioProvider.dart';
import '../view/api.dart';

final proServiceProvider =
    Provider((ref) => ProductService(ref.watch(dioProvider)));

final productProvider =
    FutureProvider((ref) => ProductService(ref.watch(dioProvider)).getData());

class ProductService implements ProductInterface {
  final Dio dio;
  ProductService(this.dio);

  @override
  Future<List<Product>> getData() async {
    try {
      final response = await dio.get(Api.baseUrl);
      final data =
          (response.data as List).map((e) => Product.fromJson(e)).toList();
      return data;
    } on DioError catch (err) {
      throw err.message;
    }
  }

  @override
  Future<Either<String, bool>> productAdd(
      {required String product_name,
      required String product_detail,
      required int price,
      required XFile image}) async {
    final box = Hive.box<User>('user').values.toList();
    try {
      final cloudinary =
          CloudinaryPublic('dx5eyrlaf', 'sample_pics', cache: false);

      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image),
        );
        await dio.post(Api.productAdd,
            data: {
              'product_name': product_name,
              'product_detail': product_detail,
              'price': price,
              'imageUrl': response.secureUrl,
              'public_id': response.publicId
            },
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
              },
            ));
      } on CloudinaryException catch (err) {
        return Left(err.responseString);
      }

      return Right(true);
    } on DioError catch (err) {
      return Left(err.message);
    }
  }

  @override
  Future<Either<String, bool>> productUpdate(
      {required String product_name,
      required String product_detail,
      required int price,
      XFile? image,
      String? imageId,
      required String productId}) async {
    final cloudinary =
        CloudinaryPublic('dx5eyrlaf', 'sample_pics', cache: false);
    final box = Hive.box<User>('user').values.toList();
    try {
      if (image == null) {
        await dio.patch(
          '${Api.productUpdate}/$productId',
          data: {
            'product_name': product_name,
            'product_detail': product_detail,
            'price': price,
            'photo': 'no need'
          },
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
            },
          ),
        );
      } else {
        try {
          CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(image.path,
                resourceType: CloudinaryResourceType.Image),
          );
          await dio.patch(
            '${Api.productUpdate}/$productId',
            data: {
              'product_name': product_name,
              'product_detail': product_detail,
              'price': price,
              'photo': response.secureUrl,
              'public_id': response.publicId,
              'oldImageId': imageId
            },
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
              },
            ),
          );
        } on CloudinaryException catch (err) {
          return Left(err.responseString);
        }
      }

      return Right(true);
    } on DioError catch (err) {
      return Left(err.message);
    }
  }

  @override
  Future<Either<String, bool>> productRemove(
      {required String productId, required String imageId}) async {
    try {
      final box = Hive.box<User>('user').values.toList();
      await dio.delete(
        '${Api.productRemove}/$productId',
        data: {'public_id': imageId},
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
          },
        ),
      );
      return Right(true);
    } on DioError catch (err) {
      return Left(err.message);
    }
  }
}
