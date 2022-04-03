abstract class MainNavigationRouteNames {
  static const mainScreen = '/';
  static const movieDetails = '/main_screen/movie_details';
}

// class MainNavigation {
//   static final _screenFactory = ScreenFactory();
//   final routes = <String, Widget Function(BuildContext)>{
//     MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
//     MainNavigationRouteNames.auth: (_) => _screenFactory.makeAuth(),
//     MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
//   };