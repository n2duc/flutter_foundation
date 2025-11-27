import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/example/example.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  static const routeName = 'example';

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _bloc = getIt<ExampleCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: BlocBuilder<ExampleCubit, ExampleState>(
        bloc: _bloc,
        builder: (context, state) {
          return switch (state) {
            ExampleStateLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ExampleStateSuccess() => ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ExampleItemCard(product: product);
              },
            ),
            ExampleStateError() => const Center(child: Text('Error')),
          };
        },
      ),
    );
  }
}
