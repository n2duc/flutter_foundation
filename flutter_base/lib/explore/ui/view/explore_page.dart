import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/explore/explore.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  static const routeName = 'explore';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: RFXSpacing.spacing160,
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
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -RFXSpacing.spacing24,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          RFXSpacing.spacing32,
                        ),
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
                ],
              ),
              const SizedBox(height: RFXSpacing.spacing48),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: RFXSpacing.spacing20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: PlaceType.values.map((item) {
                    return PlaceTypeItem(item: item);
                  }).toList(),
                ),
              ),
              Text("Suggestion Place", style: textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
