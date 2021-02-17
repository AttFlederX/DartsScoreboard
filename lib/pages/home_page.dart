import 'package:darts_scoreboard/repos/game_repository.dart';
import 'package:darts_scoreboard/widgets/dart_game_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DartGameItem> games = [];

  @override
  void initState() {
    super.initState();

    games = GameRepository.getAllGames()
        .reversed
        .map((gm) => DartGameItem(game: gm))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DartsScoreboard'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
              child: Column(
                children: [
                  // new game button
                  RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text("START NEW GAME"),
                      ],
                    ),
                    onPressed: () {},
                  ),

                  // spacing
                  SizedBox(height: 8.0),

                  // player list button
                  FlatButton(
                    child: Text('VIEW PLAYER STATS'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/player-stats');
                    },
                  ),
                ],
              ),
            ),

            // previous games title
            Text(
              'Previous games',
            ),

            SizedBox(
              height: 16.0,
            ),

            Expanded(
              child: (games.length == 0)
                  // no items placholder
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No saved games',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    )
                  // list of saved games
                  : ListView.builder(
                      itemBuilder: (_, index) => games[index],
                      itemCount: games.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
