import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/cart/cart.dart';
import 'package:flutter_base/home/home.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tourBloc = getIt<TourCubit>();

  final ValueNotifier<CategoryType> _selectedCategory =
      ValueNotifier<CategoryType>(CategoryType.airplane);

  @override
  void initState() {
    super.initState();
    tourBloc.load();
  }

  @override
  void dispose() {
    _selectedCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RFXColors.lightPrimary,
        foregroundColor: RFXColors.lightOnPrimary,
        title: Text(
          'Home Page',
          style: textTheme.titleLarge?.copyWith(
            color: RFXColors.lightOnPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(CartPage.routeName),
            icon: const Icon(Iconsax.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(RFXSpacing.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Where ever you go, \nIt\'s Beautiful Place',
              style: textTheme.headlineMedium?.copyWith(
                color: RFXColors.lightPrimary,
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing20),
            Text('This is the main content area.', style: textTheme.bodyMedium),
            SizedBox(
              height: RFXSpacing.spacing60,
              child: ValueListenableBuilder(
                valueListenable: _selectedCategory,
                builder: (context, currentSelected, _) {
                  return ListView.builder(
                    itemCount: CategoryType.values.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = CategoryType.values[index];
                      final isSelected = item == currentSelected;

                      return Row(
                        children: [
                          _buildCategoryItem(item, isSelected),
                          if (index < CategoryType.values.length - 1)
                            const SizedBox(width: RFXSpacing.small),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            // Tour list section
            BlocBuilder<TourCubit, TourState>(
              bloc: tourBloc,
              builder: (context, state) {
                return switch (state) {
                  TourStateLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  TourStateSuccess(:final tours) => Expanded(
                    child: ListView.builder(
                      itemCount: tours.length,
                      itemBuilder: (context, index) {
                        return _buildTourCard(tours[index]);
                      },
                    ),
                  ),
                  TourStateError() => const Center(
                    child: Text('Error loading tours'),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(CategoryType item, bool isSelected) {
    final icon = item.getIcon();
    final name = item.getName();

    return RFXCard.greyBorder(
      child: InkWell(
        onTap: () {
          _selectedCategory.value = item;
        },
        splashColor: RFXColors.lightOnSecondary.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? RFXColors.lightPrimary
                : RFXColors.lightOnPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(RFXSpacing.medium),
          ),
          padding: const EdgeInsets.all(RFXSpacing.spacing12),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? RFXColors.lightOnPrimary
                    : RFXColors.lightPrimary,
                size: RFXSpacing.spacing18,
              ),
              const SizedBox(width: RFXSpacing.spacing8),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? RFXColors.lightOnPrimary
                      : RFXColors.lightPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTourCard(TourData tour) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                tour.imgPath!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Iconsax.heart, color: Colors.redAccent),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(RFXSpacing.spacing12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tour.title, style: textTheme.titleSmall),
                const SizedBox(height: RFXSpacing.spacing8),
                Text(tour.description, style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
