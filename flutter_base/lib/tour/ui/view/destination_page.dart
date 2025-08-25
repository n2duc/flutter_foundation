import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key, required this.destination});

  static const routeName = 'destination';

  final Map<String, dynamic> destination;

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  final _bloc = getIt<TourCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getTourDestinationList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RFXColors.lightPrimary,
        foregroundColor: RFXColors.lightOnPrimary,
        title: Text(
          'Destination',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: RFXColors.lightOnPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: RFXSpacing.spacing12,
              horizontal: RFXSpacing.spacing24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.destination['title'],
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: RFXSpacing.spacing4),
                      Text(
                        'There are 80 interesting tourist spots',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                AvatarProfile(
                  avatarUrl:
                      "https://scontent.fdad1-2.fna.fbcdn.net/v/t39.30808-1/472327597_1940094573068233_1522880513902702645_n.jpg?stp=dst-jpg_s480x480_tt6&_nc_cat=106&ccb=1-7&_nc_sid=e99d92&_nc_ohc=fgsBxplYn64Q7kNvwH4FYi2&_nc_oc=AdkRRuhhJ0dqHhhEiKXvhZDS7AqEuJ-vgcClyxLR8u3RB_p_3lsf0GrXKIM4gaHTWzQ&_nc_zt=24&_nc_ht=scontent.fdad1-2.fna&_nc_gid=GmSdnnB-eFcXASFCxACxDA&oh=00_AfU6dLeP7wBxnDT8SKxzgrcuGOYf1OgpiWCFh2cCoQHzxQ&oe=68AB3732",
                ),
              ],
            ),
          ),

          Expanded(
            child:
                BlocSelector<TourCubit, TourState, List<Map<String, dynamic>>>(
                  bloc: _bloc,
                  selector: (state) {
                    if (state is TourStateSuccess) {
                      return state.listTourDestination;
                    }
                    return [];
                  },
                  builder: (context, tours) {
                    if (tours.isEmpty) {
                      return const ProgressLoading();
                    }
                    return ListView.separated(
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: tours.length,
                      separatorBuilder: (_, __) => const Divider(
                        color: RFXColors.lightOutlineVariant,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final tour = tours[index];
                        return TourItem(
                          tour: tour,
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
                        );
                      },
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
