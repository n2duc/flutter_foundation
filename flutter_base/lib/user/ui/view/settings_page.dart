import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/user/user.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: RFXColors.lightSurfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: RFXColors.lightOnPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2_copy,
            color: RFXColors.lightPrimary,
            size: RFXSpacing.spacing24,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'Settings',
          style: theme.textTheme.titleMedium?.copyWith(
            color: RFXColors.lightPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(RFXSpacing.spacing16),
        children: [
          SectionHeader(title: 'General'),
          _buildSwitchTile(
            context,
            title: 'Notifications',
            subtitle: 'Receive push notifications',
            value: true,
            onChanged: (value) {},
          ),
          _buildSwitchTile(
            context,
            title: 'Dark Mode',
            subtitle: 'Enable dark theme',
            value: false,
            onChanged: (value) {},
          ),
          const SizedBox(height: RFXSpacing.spacing24),
          SectionHeader(title: 'Account'),
          _buildActionTile(
            context,
            title: 'Change Password',
            icon: Iconsax.lock,
            onTap: () {},
          ),
          const SizedBox(height: RFXSpacing.spacing12),
          _buildActionTile(
            context,
            title: 'Logout',
            icon: Iconsax.logout,
            color: RFXColors.lightError,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: RFXSpacing.spacing12),
      decoration: BoxDecoration(
        color: RFXColors.lightOnPrimary,
        borderRadius: BorderRadius.circular(RFXSpacing.spacing16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: RFXColors.lightOnSurfaceVariant,
          ),
        ),
        activeThumbColor: RFXColors.lightPrimary,
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    Color? color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? RFXColors.lightOnSurface;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(RFXSpacing.spacing18),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(RFXSpacing.spacing18),
          splashColor: effectiveColor.withValues(alpha: 0.1),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(RFXSpacing.spacing16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(RFXSpacing.spacing8),
                  decoration: BoxDecoration(
                    color: effectiveColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
                  ),
                  child: Icon(
                    icon,
                    color: effectiveColor,
                    size: RFXSpacing.spacing20,
                  ),
                ),
                const SizedBox(width: RFXSpacing.spacing12),
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: effectiveColor,
                  ),
                ),
                const Spacer(),
                Icon(
                  Iconsax.arrow_right_2,
                  size: RFXSpacing.spacing16,
                  color: effectiveColor.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
