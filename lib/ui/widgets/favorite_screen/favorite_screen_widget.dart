import 'package:flutter/material.dart';
import 'package:recipes/ui/widgets/elements/elements.dart';
import 'dart:math' as math;

class FavoriteScreenWidget extends StatelessWidget {
  const FavoriteScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                    size: 24,
                    text: 'Your favorite recipes',
                    isBold: FontWeight.bold),
                const SizedBox(height: 15),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 14,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(.2),
                        width: MediaQuery.of(context).size.width / 2 - 26,
                        height: 215,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
