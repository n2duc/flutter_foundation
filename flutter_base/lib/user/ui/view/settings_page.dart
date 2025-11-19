import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
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
          _buildSectionHeader(context, 'General'),
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
          _buildSectionHeader(context, 'Account'),
          _buildActionTile(
            context,
            title: 'Change Password',
            icon: Iconsax.lock,
            onTap: () {},
          ),
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: RFXSpacing.spacing12,
        left: RFXSpacing.spacing12,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: RFXColors.lightPrimary,
          fontWeight: FontWeight.bold,
        ),
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
        activeColor: RFXColors.lightPrimary,
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
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(RFXSpacing.spacing8),
          decoration: BoxDecoration(
            color: effectiveColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
          ),
          child: Icon(icon, color: effectiveColor, size: RFXSpacing.spacing20),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: effectiveColor,
          ),
        ),
        trailing: Icon(
          Iconsax.arrow_right_2,
          size: RFXSpacing.spacing16,
          color: effectiveColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
