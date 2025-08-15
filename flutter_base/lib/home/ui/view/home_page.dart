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
                            CategoryItem(
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
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: tours.length,
                      itemBuilder: (context, index) {
                        return TourCard(tour: tours[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: RFXSpacing.spacing12);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: RFXSpacing.spacing20),
              //Tour Event Section
              Row(
                children: [
                  const SizedBox(width: RFXSpacing.spacing4),
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
              const SizedBox(height: RFXSpacing.spacing6),
              BlocSelector<TourCubit, TourState, List<Map<String, dynamic>>>(
                bloc: _tourBloc,
                selector: (state) => (state.listEvent),
                builder: (context, events) {
                  if (events.isEmpty) {
                    return ProgressLoading();
                  }
                  return SizedBox(
                    height: RFXSpacing.spacing144,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const columnCount = 2;
                        final itemWidth =
                            constraints.maxWidth / columnCount -
                            (RFXSpacing.spacing4 / columnCount);
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: RFXSpacing.spacing4,
                                mainAxisSpacing: RFXSpacing.spacing4,
                                mainAxisExtent: itemWidth,
                              ),
                          itemBuilder: (context, index) {
                            return TourEventCard(event: events[index]);
                          },
                        );
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
