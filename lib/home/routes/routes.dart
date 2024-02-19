import 'package:fluttartur/home/home.dart';
import 'package:fluttartur/lobby/view/view.dart';
import 'package:fluttartur/matchup/matchup.dart';
import 'package:fluttartur/game/game.dart';
import 'package:flutter/widgets.dart';

List<Page<dynamic>> onGenerateRoomViewPages(
  HomeStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case HomeStatus.inLobby:
      return [LobbyPage.page()];
    case HomeStatus.inMathup:
      return [MatchupPage.page(isHost: false)];
    case HomeStatus.inMathupIsHost:
      return [MatchupPage.page(isHost: true)];
    case HomeStatus.inGame:
      return [GamePage.page()];
  }
}
