import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({super.key, required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(RFXSpacing.spacing4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: CircleAvatar(
              radius: RFXSpacing.spacing20,
              backgroundImage: NetworkImage(avatarUrl),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(RFXSpacing.spacing6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlueAccent,
                border: Border.all(color: RFXColors.lightSurface, width: 3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
