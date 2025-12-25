import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/example/example.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/design_system/widgets/resizable_split_layout.dart';

class ProductResponsivePage extends StatefulWidget {
  const ProductResponsivePage({super.key});

  static const routeName = 'product_responsive';

  @override
  State<ProductResponsivePage> createState() => _ProductResponsivePageState();
}

class _ProductResponsivePageState extends State<ProductResponsivePage> {
  final _bloc = getIt<ExampleCubit>();
  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
    _bloc.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Master-Detail')),
      body: BlocBuilder<ExampleCubit, ExampleState>(
        bloc: _bloc,
        builder: (context, state) {
          return switch (state) {
            ExampleStateLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ExampleStateSuccess() => _buildContent(context, state.products),
            ExampleStateError() => const Center(child: Text('Error')),
          };
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Product> products) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    return isPortrait
        ? _buildPortraitLayout(products)
        : _buildLandscapeLayout(products);
  }

  Widget _buildPortraitLayout(List<Product> products) {
    return Column(
      children: [
        Expanded(flex: 1, child: _buildProductList(products)),
        const Divider(height: 1, thickness: 1),
        Expanded(flex: 1, child: _buildProductDetail()),
      ],
    );
  }

  Widget _buildLandscapeLayout(List<Product> products) {
    return ResizableSplitLayout(
      leftChild: _buildProductList(products),
      rightChild: _buildProductDetail(),
      initialLeftWidth: 700,
      minRightWidth: 500,
      maxRightWidth: 700,
    );
  }

  Widget _buildProductList(List<Product> products) {
    return Column(
      children: [
        // Table Header
        Container(
          padding: const EdgeInsets.all(12.0),
          color: Colors.grey.withValues(alpha: 0.1),
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'ID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Table Body
        Expanded(
          child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final product = products[index];
              final isSelected = product == _selectedProduct;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedProduct = product;
                  });
                },
                child: Container(
                  color: isSelected ? Colors.blue.withValues(alpha: 0.1) : null,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(product.id.toStringAsFixed(0)),
                      ),
                      Expanded(flex: 3, child: Text(product.title)),
                      Expanded(
                        flex: 2,
                        child: Text('\$${product.price.toStringAsFixed(2)}'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetail() {
    if (_selectedProduct == null) {
      return const Center(
        child: Text(
          'Select a product to view details',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    final product = _selectedProduct!;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'ID: ${product.id}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Image.network(product.image),
          ],
        ),
      ),
    );
  }
}
