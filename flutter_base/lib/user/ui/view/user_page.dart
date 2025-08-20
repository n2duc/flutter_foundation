import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/user/user.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  static const routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: RFXSpacing.spacing280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatar.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(RFXSpacing.spacing24),
                  ),
                ),
              ),
            ),
            Positioned(
              top: RFXSpacing.spacing200,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: RFXSpacing.spacing24,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: RFXSpacing.spacing24,
                  vertical: RFXSpacing.spacing20,
                ),
                decoration: BoxDecoration(
                  color: RFXColors.lightOnPrimary,
                  borderRadius: BorderRadius.circular(RFXSpacing.spacing24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: RFXSpacing.spacing12,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Duc Sucana',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: RFXSpacing.spacing8),
                            Icon(
                              Iconsax.verify,
                              size: RFXSpacing.spacing20,
                              color: RFXColors.lightPrimary,
                            ),
                          ],
                        ),
                        const SizedBox(height: RFXSpacing.spacing12),
                        Text(
                          'Bullet editor invite shadow create effect scrolling community shadow',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: RFXSpacing.spacing24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RFXOutlinedButton.small(
                            onPressed: () {},
                            title: 'Edit Profile',
                          ),
                        ),
                        const SizedBox(width: RFXSpacing.spacing20),
                        Expanded(
                          child: RFXOutlinedButton.small(
                            onPressed: () {},
                            title: 'Verification',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: RFXSpacing.spacing12),
                    Column(
                      children: [
                        ...MenuType.values.map((menu) {
                          return MenuItem(menu: menu);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
