import 'dart:convert';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: RFXSpacing.spacing16,
                vertical: RFXSpacing.spacing16,
              ),
              child: Text(
                'Where ever you go, \nIt\'s Beautiful Place',
                style: textTheme.headlineMedium?.copyWith(
                  color: RFXColors.lightPrimary,
                ),
              ),
            ),
            SizedBox(
              height: RFXSpacing.spacing40,
              child: ValueListenableBuilder(
                valueListenable: _selectedCategory,
                builder: (context, currentSelected, _) {
                  return ListView.separated(
                    itemCount: CategoryType.values.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = CategoryType.values[index];
                      final isSelected = item == currentSelected;

                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(left: RFXSpacing.spacing16),
                          child: CategoryItem(
                            item: item,
                            isSelected: isSelected,
                            onTap: () {
                              _selectedCategory.value = item;
                            },
                          ),
                        );
                      }

                      if (index == CategoryType.values.length - 1) {
                        return Padding(
                          padding: EdgeInsets.only(right: RFXSpacing.spacing16),
                          child: CategoryItem(
                            item: item,
                            isSelected: isSelected,
                            onTap: () {
                              _selectedCategory.value = item;
                            },
                          ),
                        );
                      }

                      return CategoryItem(
                        item: item,
                        isSelected: isSelected,
                        onTap: () {
                          _selectedCategory.value = item;
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: RFXSpacing.spacing12);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing20),
            SectionHeading(title: 'Popular Tours', icon: Iconsax.trend_up),
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
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: tours.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? RFXSpacing.spacing16 : 0,
                          right: index == tours.length - 1
                              ? RFXSpacing.spacing16
                              : 0,
                        ),
                        child: TourCard(
                          tour: tours[index],
                          onTap: () {
                            final encode = Uri.encodeComponent(
                              jsonEncode(tours[index]),
                            );
                            context.pushNamed(
                              TourDetailPage.routeName,
                              extra: tours[index],
                              queryParameters: {'tour': encode},
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: RFXSpacing.spacing12);
                    },
                  ),
                );
              },
            ),
            //Tour Event Section
            SectionHeading(title: 'Tour Events', icon: Iconsax.calendar_1),
            BlocSelector<TourCubit, TourState, List<Map<String, dynamic>>>(
              bloc: _tourBloc,
              selector: (state) => (state.listEvent),
              builder: (context, events) {
                if (events.isEmpty) {
                  return ProgressLoading();
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: RFXSpacing.spacing16),
                  child: SizedBox(
                    height: RFXSpacing.spacing132,
                    width: double.infinity,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const rowCount = 2;
                        final itemWidth =
                            constraints.maxWidth / rowCount -
                            (RFXSpacing.spacing4 * (rowCount - 1));
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: rowCount,
                                crossAxisSpacing: RFXSpacing.small,
                                mainAxisSpacing: RFXSpacing.small,
                                mainAxisExtent: itemWidth,
                              ),
                          itemBuilder: (context, index) {
                            final isLastColumn =
                                index >=
                                ((events.length / rowCount).ceil() - 1) *
                                    rowCount;
                            return Padding(
                              padding: EdgeInsets.only(
                                right: isLastColumn ? RFXSpacing.spacing12 : 0,
                                left: index <= rowCount - 1
                                    ? RFXSpacing.spacing12
                                    : 0,
                              ),
                              child: TourEventCard(
                                event: events[index],
                                onTap: () {
                                  //TODO(Duc): Call api and handle next detail event tour page
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
