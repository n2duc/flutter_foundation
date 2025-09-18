import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MesssagePage extends StatefulWidget {
  const MesssagePage({super.key});

  static const routeName = 'message';

  @override
  State<MesssagePage> createState() => _MesssagePageState();
}

class _MesssagePageState extends State<MesssagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: RFXSpacing.spacing16,
              backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBob3RvfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
              ),
            ),
            const SizedBox(width: RFXSpacing.spacing12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jane Doe',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: RFXColors.lightPrimary,
                  ),
                ),
                Text(
                  'Online',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: RFXColors.lightPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_copy,
            color: RFXColors.lightPrimary,
            size: RFXSpacing.spacing24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.video_copy)),
          Padding(
            padding: const EdgeInsets.only(right: RFXSpacing.spacing12),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.call_copy),
            ),
          ),
        ],
        backgroundColor: RFXColors.lightOnPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(RFXSpacing.spacing20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: RFXSpacing.spacing16,
                vertical: RFXSpacing.spacing8,
              ),
              child: Column(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: RFXSpacing.spacing12,
              horizontal: RFXSpacing.spacing16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(RFXSpacing.extraLarge),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.image_outlined, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
