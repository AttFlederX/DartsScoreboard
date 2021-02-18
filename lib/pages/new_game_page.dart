import 'package:darts_scoreboard/models/ui/dart_game.dart';
import 'package:darts_scoreboard/models/ui/player.dart';
import 'package:darts_scoreboard/repos/player_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewGamePage extends StatefulWidget {
  @override
  _NewGamePageState createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage> {
  List<Player> _addedPlayers = PlayerRepository.getAllPlayers();
  int _initScore = 501;
  bool _isNorthernBust = false;
  bool _isDoublingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New game'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        // page content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // player title
            Text('Players'),

            // added players list
            Expanded(
              flex: 1,
              child: _addedPlayers.length == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No players added',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      primary: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.0),
                      childAspectRatio: 4.0 / 1.0,
                      children: _buildAddedPlayersList(context),
                    ),
            ),

            // add players button
            RaisedButton(
              child: Text('ADD PLAYERS'),
              onPressed: () {},
            ),
            SizedBox(height: 24.0),

            // initial score title
            Text('Initial score'),
            SizedBox(height: 8.0),

            // initial score setter
            Row(
              children: [
                // 301
                Flexible(
                  flex: 1,
                  child: RadioListTile(
                    title: Text('301'),
                    value: 301,
                    groupValue: _initScore,
                    onChanged: (value) {
                      setState(() {
                        _initScore = value;
                      });
                    },
                  ),
                ),

                // 501
                Flexible(
                  flex: 1,
                  child: RadioListTile(
                    title: Text('501'),
                    value: 501,
                    groupValue: _initScore,
                    onChanged: (value) {
                      setState(() {
                        _initScore = value;
                      });
                    },
                  ),
                ),

                // 701
                Flexible(
                  flex: 1,
                  child: RadioListTile(
                    title: Text('701'),
                    value: 701,
                    groupValue: _initScore,
                    onChanged: (value) {
                      setState(() {
                        _initScore = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),

            // additional settings title
            Text('Additional settings'),
            SizedBox(height: 8.0),

            // additional settings setter
            Column(
              children: [
                // northern bust
                CheckboxListTile(
                  title: Text('Northern bust'),
                  value: _isNorthernBust,
                  onChanged: (value) {
                    setState(() {
                      _isNorthernBust = value;
                    });
                  },
                ),

                // doubling-in
                CheckboxListTile(
                  title: Text('Doubling-in'),
                  value: _isDoublingIn,
                  onChanged: (value) {
                    setState(() {
                      _isDoublingIn = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32.0),

            // play button
            RaisedButton(
              child: Text('PLAY'),
              onPressed: () {},
            ),
            SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAddedPlayersList(BuildContext context) {
    return _addedPlayers
        .map((pl) => Material(
              elevation: 8.0,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // player name
                    Expanded(
                      child: Text(
                        pl.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),

                    // remove button
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _addedPlayers.remove(pl);
                        });
                      },
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }
}
