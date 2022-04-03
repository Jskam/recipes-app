import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/ui/widgets/details_screen/details_screen_model.dart';
import 'package:recipes/ui/widgets/elements/elements.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreenWidget extends StatelessWidget {
  const DetailsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DetailsScreenModel>();
    final recipe = model.recipe?.meals?[0];
    return Scaffold(
      body: model.recipe == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    expandedHeight: 300.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        recipe!.strCategory.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      background: Stack(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: double.infinity,
                              child: Image.network(
                                recipe.strMealThumb ??
                                    'https://picsum.photos/400/200',
                                fit: BoxFit.cover,
                              )),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                stops: const [0.6, 1],
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 30, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: Text(
                                    recipe.strMeal ?? '',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: "Sigmar"),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 45,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                padding: const EdgeInsets.all(20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            size: 26,
                            text: recipe!.strMeal ?? '',
                            isBold: FontWeight.w600,
                          ),
                        ),
                        recipe.strYoutube != null &&  recipe.strYoutube!.contains('https://www.youtube.com/watch?v=')&&
                                recipe.strYoutube!.isNotEmpty
                            ? _TrailerWidget(
                                trailerKey: recipe
                                    .strYoutube!) // ,_PlayerWidget(youTubeKey: )
                            : Text(''),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const _ProductsWidget(),
                    const SizedBox(height: 20),
                    recipe.strInstructions != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                size: 22,
                                text: 'Overview',
                              ),
                              const SizedBox(height: 5),
                              AppText(
                                size: 18,
                                text: recipe.strInstructions ?? '',
                              ),
                            ],
                          )
                        : Text(''),
                    const SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () async {
                        var url = recipe.strSource!;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      elevation: 2,
                      child: AppText(
                        size: 20,
                        text: 'Open in browser',
                        color: Colors.white,
                      ),
                      color: Colors.green[700],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _ProductsWidget extends StatelessWidget {
  const _ProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<DetailsScreenModel>();
    return SizedBox(
      height: 130,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: model.products.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    size: 16,
                    text: model.products[index]['weight'],
                    alignCenter: true,
                  ),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://themealdb.com/images/ingredients/${model.products[index]['name']}.png',
                    ),
                  ),
                  AppText(
                    size: 16,
                    text: model.products[index]['name'],
                    alignCenter: true,
                    overflow: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TrailerWidget extends StatefulWidget {
  final String trailerKey;
  const _TrailerWidget({Key? key, required this.trailerKey}) : super(key: key);
  @override
  State<_TrailerWidget> createState() => __TrailerWidgetState();
}

class __TrailerWidgetState extends State<_TrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.trailerKey.substring(32),
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          builder: (BuildContext context) {
            return _showTrailerBottomSheet(
              widget.trailerKey.substring(32),
              _controller,
            );
          },
        );
      },
      child: Row(
        children: [
          const Icon(
            Icons.play_arrow,
            color: Colors.green,
          ),
          AppText(
              size: 16,
              text: 'Guide',
              color: Colors.green[700]!,
              isBold: FontWeight.bold),
        ],
      ),
    );
  }
}

Widget _showTrailerBottomSheet(
    String trailerKey, YoutubePlayerController controller) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      color: Color.fromRGBO(24, 23, 27, 1),
    ),
    child: YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return player;
      },
    ),
  );
}
