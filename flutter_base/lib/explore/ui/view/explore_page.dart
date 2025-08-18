import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/explore/explore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  static const routeName = 'explore';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _bloc = getIt<ExploreCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.load();
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
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: RFXSpacing.spacing4),
                            Text(
                              'Discover new places and experiences',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(color: Colors.white),
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
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Search Your Destination',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: RFXSpacing.spacing20,
                          vertical: RFXSpacing.spacing12,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Iconsax.search_normal_1_copy,
                            color: RFXColors.lightPrimary,
                            size: RFXSpacing.spacing18,
                          ),
                          onPressed: () {
                            // Handle search action
                          },
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
                      vertical: RFXSpacing.small,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final rowWidth = constraints.maxWidth;
                        final spacing = RFXSpacing.small;
                        final length = PlaceType.values.length;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      "Suggestion Place",
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
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: places.length,
                        separatorBuilder: (_, __) => const Divider(
                          color: RFXColors.lightOutlineVariant,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final place = places[index];
                          return PlaceCard(place: place);
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
