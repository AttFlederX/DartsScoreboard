import 'package:darts_scoreboard/pages/new_game_page.dart';
import 'package:darts_scoreboard/pages/player_list_page.dart';
import 'package:darts_scoreboard/pages/player_stats_page.dart';
import 'package:flutter/material.dart';

import 'pages/game_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(DartsScoreboardApp());
}

class DartsScoreboardApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DartsScoreboard',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // navigation
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        var routes = {
          '/': (ctx) => HomePage(),
          '/new-game': (ctx) => NewGamePage(),
          '/game': (ctx) => GamePage(),
          '/player-stats': (ctx) => PlayerStatsPage(),
          '/player-list': (ctx) => PlayerListPage(settings.arguments),
        };

        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
