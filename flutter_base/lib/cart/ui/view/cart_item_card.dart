import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/cart/cart.dart';
import 'package:flutter_base/tour/tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({super.key, required this.tour});

  final Map<String, dynamic> tour;

  final _bloc = getIt<CartCubit>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: RFXColors.lightOnPrimary,
        borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
      ),
      padding: const EdgeInsets.only(
        bottom: RFXSpacing.spacing12,
        top: RFXSpacing.spacing12,
      ),
      child: Slidable(
        key: ValueKey(tour['id']),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.45,
          children: [
            SlidableAction(
              onPressed: (_) => {},
              padding: EdgeInsets.zero,
              backgroundColor: RFXColors.lightPrimary,
              foregroundColor: Colors.white,
              icon: Iconsax.archive,
              label: 'Archive',
            ),
            SlidableAction(
              onPressed: (_) => _bloc.removeTourFromCart(tour['id']),
              padding: EdgeInsets.zero,
              backgroundColor: RFXColors.lightSecondary,
              foregroundColor: Colors.white,
              icon: Iconsax.trash,
              label: 'Remove',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            context.pushNamed(TourDetailPage.routeName, extra: tour);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: RFXSpacing.spacing12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocSelector<CartCubit, CartState, bool>(
                  bloc: _bloc,
                  selector: (state) =>
                      state.cartTours.firstWhere(
                            (item) => item['id'] == tour['id'],
                            orElse: () => {'isSelected': false},
                          )['isSelected']
                          as bool? ??
                      false,
                  builder: (context, isSelected) {
                    return InkWell(
                      onTap: () => _bloc.toggleItemSelection(tour['id']),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: RFXSpacing.spacing42,
                          horizontal: RFXSpacing.spacing12,
                        ),
                        child: RFXCheckbox(
                          value: isSelected,
                          onChanged: () =>
                              _bloc.toggleItemSelection(tour['id']),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing6),
                    child: Image.asset(
                      tour['imgPath']!,
                      width: RFXSpacing.spacing120,
                      height: RFXSpacing.spacing100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: RFXSpacing.spacing12),
                Expanded(
                  child: SizedBox(
                    height: RFXSpacing.spacing100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tour['title'],
                              style: textTheme.bodyMedium?.copyWith(
                                color: RFXColors.lightPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: RFXSpacing.spacing4),
                            Text(
                              tour['description'],
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${tour['price']}',
                              style: textTheme.bodyMedium?.copyWith(
                                color: RFXColors.lightPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BlocSelector<CartCubit, CartState, int>(
                              bloc: _bloc,
                              selector: (state) => state.cartTours.firstWhere(
                                (item) => item['id'] == tour['id'],
                                orElse: () => {},
                              )['count'],
                              builder: (context, count) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: RFXSpacing.spacing28,
                                      height: RFXSpacing.spacing28,
                                      child: IconButton(
                                        iconSize: RFXSpacing.spacing18,
                                        padding: EdgeInsets.zero,
                                        onPressed: count > 1
                                            ? () {
                                                _bloc.decreaseTourCount(
                                                  tour['id'],
                                                );
                                              }
                                            : null,
                                        icon: const Icon(Icons.remove),
                                      ),
                                    ),
                                    SizedBox(
                                      width: RFXSpacing.spacing40,
                                      child: Center(
                                        child: Text(
                                          '$count',
                                          style: textTheme.bodySmall,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: RFXSpacing.spacing28,
                                      height: RFXSpacing.spacing28,
                                      child: IconButton(
                                        iconSize: RFXSpacing.spacing18,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          _bloc.increaseTourCount(tour['id']);
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
