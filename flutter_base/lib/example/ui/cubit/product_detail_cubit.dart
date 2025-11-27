import 'package:bloc/bloc.dart';
import 'package:flutter_base/example/data/models/example_model.dart';
import 'package:flutter_base/example/data/repositories/example_repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'product_detail_cubit.freezed.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({required this.exampleRepositories})
    : super(const ProductDetailState.loading());

  static final log = Logger('ProductDetailCubit');

  final ExampleRepositories exampleRepositories;

  Future<void> fetchProduct(double id) async {
    emit(const ProductDetailState.loading());
    try {
      final product = await exampleRepositories.getProduct(id);
      log.info('Product fetched successfully');
      emit(ProductDetailState.success(product: product));
    } catch (e) {
      log.severe('Failed to fetch product', e);
      emit(ProductDetailState.error(errorMessage: e.toString()));
    }
  }
}

@freezed
sealed class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.loading() = ProductDetailStateLoading;
  const factory ProductDetailState.success({required Product product}) =
      ProductDetailStateSuccess;
  const factory ProductDetailState.error({required String errorMessage}) =
      ProductDetailStateError;
}
