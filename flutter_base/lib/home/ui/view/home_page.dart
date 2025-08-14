import 'dart:ui';

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
  final _tourBloc = getIt<TourCubit>();

  final _selectedCategory = ValueNotifier<CategoryType>(CategoryType.airplane);

  @override
  void initState() {
    super.initState();
    _tourBloc.load();
    _tourBloc.getEventList();
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
      body: SingleChildScrollView(
        child: Padding(
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
              Text(
                'This is the main content area.',
                style: textTheme.bodyMedium,
              ),
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
                            _CategoryItem(
                              item: item,
                              isSelected: isSelected,
                              onTap: () {
                                _selectedCategory.value = item;
                              },
                            ),
                            if (index < CategoryType.values.length - 1)
                              const SizedBox(width: RFXSpacing.small),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: RFXSpacing.spacing20),
              // Tour List Section
              BlocSelector<TourCubit, TourState, List<Map<String, dynamic>>>(
                bloc: _tourBloc,
                selector: (state) => (state.listTour),
                builder: (context, tours) {
                  if (tours.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tours.length,
                      itemBuilder: (context, index) {
                        return _TourCard(tour: tours[index]);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: RFXSpacing.spacing20),
              //Tour Event Section
              Row(
                children: [
                  Icon(
                    Iconsax.calendar,
                    color: RFXColors.lightPrimary,
                    size: RFXSpacing.spacing18,
                  ),
                  const SizedBox(width: RFXSpacing.spacing6),
                  Text(
                    'Tour Events',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              BlocSelector<TourCubit, TourState, List<Map<String, dynamic>>>(
                bloc: _tourBloc,
                selector: (state) => (state.listEvent),
                builder: (context, events) {
                  if (events.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    height: RFXSpacing.spacing144,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: RFXSpacing.spacing4,
                            mainAxisSpacing: RFXSpacing.spacing6,
                            childAspectRatio: 0.3,
                          ),
                      itemBuilder: (context, index) {
                        return _TourEventCard(event: events[index]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TourCard extends StatelessWidget {
  const _TourCard({required this.tour});

  final Map<String, dynamic> tour;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: RFXColors.lightOnPrimary,
      child: SizedBox(
        width: RFXSpacing.spacing240,
        child: Column(
          children: [
            Stack(
              children: [
                // border radius for image
                ClipRRect(
                  borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
                  child: Image.asset(
                    tour['imgPath']!,
                    height: RFXSpacing.spacing280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: RFXSpacing.spacing12,
                  right: RFXSpacing.spacing12,
                  child: Container(
                    width: RFXSpacing.spacing32,
                    height: RFXSpacing.spacing32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Iconsax.heart,
                        color: Colors.redAccent,
                        size: RFXSpacing.spacing20,
                      ),
                      onPressed: null,
                    ),
                  ),
                ),

                Positioned(
                  bottom: RFXSpacing.spacing12,
                  left: RFXSpacing.spacing12,
                  // Using ClipRRect to apply border radius and backdrop filter to the rating container
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: RFXSpacing.spacing6,
                        sigmaY: RFXSpacing.spacing6,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: RFXColors.lightPrimary.withValues(alpha: 0.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: RFXSpacing.spacing6,
                          vertical: RFXSpacing.spacing2,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: RFXColors.lightOnPrimary,
                              size: RFXSpacing.spacing20,
                            ),
                            const SizedBox(width: RFXSpacing.spacing6),
                            Text(
                              '${tour['rating']}/5.0',
                              style: textTheme.bodyMedium?.copyWith(
                                color: RFXColors.lightOnPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(RFXSpacing.spacing12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tour['title'], style: textTheme.titleMedium),
                  const SizedBox(height: RFXSpacing.spacing8),
                  Text(
                    tour['description'],
                    style: textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: RFXSpacing.spacing8),
                  Text(
                    'Start from ${tour['price']} VND / day',
                    style: textTheme.bodySmall?.copyWith(
                      color: RFXColors.lightPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryType item;
  final bool isSelected;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final itemIcon = item.getIcon();
    final itemName = item.getName();
    return RFXCard.greyBorder(
      child: InkWell(
        onTap: onTap,
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
                itemIcon,
                color: isSelected
                    ? RFXColors.lightOnPrimary
                    : RFXColors.lightPrimary,
                size: RFXSpacing.spacing18,
              ),
              const SizedBox(width: RFXSpacing.spacing8),
              Text(
                itemName,
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
}

class _TourEventCard extends StatelessWidget {
  const _TourEventCard({required this.event});

  final Map<String, dynamic> event;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: RFXColors.lightOnPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: RFXSpacing.spacing6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(RFXSpacing.spacing6),
              child: Image.asset(
                event['imgPath']!,
                height: RFXSpacing.spacing48,
                width: RFXSpacing.spacing56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: RFXSpacing.spacing12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event['title'],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RFXColors.lightPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: RFXSpacing.spacing4),
                Text(
                  event['description'],
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
