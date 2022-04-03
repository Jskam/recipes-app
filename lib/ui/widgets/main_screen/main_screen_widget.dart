// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/ui/widgets/elements/elements.dart';
import 'package:recipes/ui/widgets/main_screen/main_screen_model.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenModel>();
    return Scaffold(
      body: model.populars != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Header(),
                    const SizedBox(height: 20),
                    _AreaWidget(),
                    const SizedBox(height: 30),
                    const _PopularWidget(),
                    const SizedBox(height: 30),
                    const _RecomendedWidget(),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _RecomendedWidget extends StatelessWidget {
  const _RecomendedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final length = model.populars?.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                size: 22,
                text: 'Recomended',
                isBold: FontWeight.bold,
              ),
              AppText(
                size: 18,
                text: 'see more',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final recipe = model.populars![index];
              return GestureDetector(
                 onTap: () => model.onRecipeTap(context, recipe.idMeal!),
                child: Container(
                  child: ProductWidget(
                    imgurl: recipe.strMealThumb,
                    name: recipe.strMeal,
                    time: '10 min',
                    rating: 5,
                    width: MediaQuery.of(context).size.width / 2 - 26,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PopularWidget extends StatelessWidget {
  const _PopularWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final length = model.populars?.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                size: 22,
                text: 'Popular',
                isBold: FontWeight.bold,
              ),
              AppText(
                size: 18,
                text: 'see more',
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final recipe = model.populars![index];
              return GestureDetector(
                onTap: () => model.onRecipeTap(context, recipe.idMeal!),
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
                  child: ProductWidget(
                    imgurl: recipe.strMealThumb,
                    name: recipe.strMeal,
                    time: '10 min',
                    rating: 5,
                  ),
                ),
              );
            },
            itemCount: length,
          ),
        ),
      ],
    );
  }
}

class _AreaWidget extends StatelessWidget {
  _AreaWidget({
    Key? key,
  }) : super(key: key);

  final countries = [
    
    'american',
    'chinese',
    'japanese',
    'russian',
    'dutch',
    'spanish',
    'turkish',
    'british',
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppText(
            size: 22,
            text: 'Cuisines of the world',
            isBold: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 80,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => model.onCountryTap(context, countries[index]),
                child: Container(
                  margin: EdgeInsets.only(right: 25, left: index == 0 ? 20 : 0),
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/${countries[index]}.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.orange,
                child: Icon(Icons.person, size: 46, color: Colors.white),
              ),
              const SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(size: 16, text: 'Hi, Person!'),
                  AppText(size: 22, text: 'What are u want today?'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF3F6F8),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.search, size: 22),
                const SizedBox(width: 6),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search..',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

