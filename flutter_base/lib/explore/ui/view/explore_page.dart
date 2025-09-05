import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/explore/explore.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  static const routeName = 'explore';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _bloc = getIt<ExploreCubit>();
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filterPlaces(List<Map<String, dynamic>> places) {
    if (_searchQuery.isEmpty) {
      return places;
    }

    return places.where((place) {
      final title = place['title']?.toString().toLowerCase() ?? '';
      final description = place['description']?.toString().toLowerCase() ?? '';
      final location = place['location']?.toString().toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();

      return title.contains(query) ||
          description.contains(query) ||
          location.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: RFXSpacing.spacing200,
              floating: false,
              pinned: true,
              backgroundColor: RFXColors.lightPrimary,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: RFXSpacing.spacing200,
                      decoration: BoxDecoration(
                        color: RFXColors.lightPrimary,
                        image: DecorationImage(
                          image: AssetImage('assets/images/hoian.jpg'),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          opacity: 0.6,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Choose Your Adventure',
                              style: textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: RFXSpacing.spacing4),
                            Text(
                              'Discover new places and experiences',
                              style: textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: RFXSpacing.spacing40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                // PreferredSize is a widget that sizes its child to a specific size.
                preferredSize: Size.fromHeight(RFXSpacing.spacing24),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: RFXSpacing.spacing16,
                    left: RFXSpacing.spacing28,
                    right: RFXSpacing.spacing28,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.86,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(RFXSpacing.spacing32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.center,
                      style: textTheme.bodyMedium,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Your Destination',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: RFXSpacing.spacing20,
                          vertical: RFXSpacing.spacing12,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                  size: RFXSpacing.spacing18,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : Icon(
                                Iconsax.search_normal_1_copy,
                                color: RFXColors.lightPrimary,
                                size: RFXSpacing.spacing18,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: RFXSpacing.small),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: RFXSpacing.medium,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final rowWidth = constraints.maxWidth;
                        final spacing = RFXSpacing.small;
                        final length = PlaceType.values.length;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...PlaceType.values.map((item) {
                              return PlaceTypeItem(
                                item: item,
                                maxWidth: (rowWidth / length) - spacing,
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: RFXSpacing.spacing28,
                      vertical: RFXSpacing.small,
                    ),
                    child: Text(
                      _searchQuery.isNotEmpty
                          ? "Search Results"
                          : "Suggestion Place",
                      style: textTheme.titleMedium?.copyWith(
                        color: RFXColors.lightPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  BlocSelector<
                    ExploreCubit,
                    ExploreState,
                    List<Map<String, dynamic>>
                  >(
                    bloc: _bloc,
                    selector: (state) {
                      if (state is ExploreStateSuccess) {
                        return state.listPlace;
                      }
                      return [];
                    },
                    builder: (context, places) {
                      if (places.isEmpty) {
                        return const ProgressLoading();
                      }

                      final filteredPlaces = _filterPlaces(places);

                      if (filteredPlaces.isEmpty && _searchQuery.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(RFXSpacing.spacing28),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Iconsax.search_normal_1_copy,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: RFXSpacing.spacing16),
                                Text(
                                  'No places found for "$_searchQuery"',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: RFXSpacing.spacing8),
                                Text(
                                  'Try searching with different keywords',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredPlaces.length,
                        separatorBuilder: (_, __) => const Divider(
                          color: RFXColors.lightOutlineVariant,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final place = filteredPlaces[index];
                          return PlaceCard(
                            place: place,
                            onTap: () {
                              context.pushNamed(
                                DestinationPage.routeName,
                                extra: place,
                              );
                            },
                          );
                        },
                      );
                    },
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
