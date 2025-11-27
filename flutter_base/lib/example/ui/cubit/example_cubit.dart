import 'package:bloc/bloc.dart';
import 'package:flutter_base/example/data/models/example_model.dart';
import 'package:flutter_base/example/data/repositories/example_repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
part 'example_cubit.freezed.dart';

class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit({required this.exampleRepositories})
    : super(const ExampleState.loading());

  static final log = Logger('ExampleCubit');

  @visibleForTesting
  final ExampleRepositories exampleRepositories;

  Future<void> fetchProducts() async {
    emit(const ExampleState.loading());
    try {
      final products = await exampleRepositories.getProducts();
      log.info('Products fetched successfully');
      emit(ExampleState.success(products: products));
    } catch (e) {
      log.severe('Failed to fetch products', e);
      emit(ExampleState.error(errorMessage: e.toString()));
    }
  }
}

@freezed
sealed class ExampleState with _$ExampleState {
  const factory ExampleState.loading() = ExampleStateLoading;
  const factory ExampleState.success({required List<Product> products}) =
      ExampleStateSuccess;
  const factory ExampleState.error({required String errorMessage}) =
      ExampleStateError;
}
