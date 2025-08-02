import 'package:flutter/material.dart';
import 'package:flutter_learn/components/button.dart';
import 'package:flutter_learn/pages/menu_page.dart';
import 'package:flutter_learn/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  static const routeName = 'intro';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 24),
            Text(
              "SUSHI MAN",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Image.asset('lib/images/salmon_eggs.png'),
            ),
            const SizedBox(height: 24),
            Text(
              "THE TASTE OF JAPANESE FOOD",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 44,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Feel the taste of the most popular Japanese food from anywhere and anytime.",
              style: TextStyle(color: Colors.grey[300], height: 2),
            ),
            const SizedBox(height: 24),
            MyButton(
              text: "Get Started",
              onTap: () => context.go('/${MenuPage.routeName}'),
            ),
          ],
        ),
      ),
    );
  }
}
