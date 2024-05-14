import 'package:data_repository/model/model.dart';
import 'package:fluttartur/fluttartur_icons_icons.dart';
import 'package:fluttartur/game/cubit/game_cubit.dart';
import 'package:fluttartur/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> pushGameResultsDialog(
  BuildContext gameContext, {
  required bool goodWin,
}) {
  return showDialog<void>(
      barrierDismissible: false,
      context: gameContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(gameContext)!.gameResults),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                  goodWin
                      ? FluttarturIcons.crown
                      : FluttarturIcons.crossed_swords,
                  size: 80),
              Card(
                color: goodWin ? Colors.green.shade900 : Colors.red.shade900,
                child: Center(
                  heightFactor: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      goodWin
                          ? AppLocalizations.of(gameContext)!.goodTeamWon
                          : AppLocalizations.of(gameContext)!.evilTeamWon,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(AppLocalizations.of(gameContext)!.evilCourtiers,
                  style: const TextStyle(fontSize: 25)),
              _EvilCourtiersList(gameContext: gameContext),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                gameContext.read<HomeCubit>().leaveMatchup();
              },
              child: Text(AppLocalizations.of(gameContext)!.exitGame,
                  style: const TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(AppLocalizations.of(gameContext)!.closeInfo,
                  style: const TextStyle(fontSize: 20)),
            ),
          ],
        );
      });
}

class _EvilCourtiersList extends StatelessWidget {
  const _EvilCourtiersList({required this.gameContext});
  final BuildContext gameContext;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
      future: gameContext.read<GameCubit>().getEvilPlayers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<Player> evilPlayers = snapshot.data ?? List.empty();
        return Wrap(
          children: <Widget>[
            ...evilPlayers.map(
              (player) => Text("${player.nick}, ",
                  style: const TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }
}

class _MerlinKilledResult extends StatelessWidget {
  const _MerlinKilledResult({required this.merlinKilled});

  final bool merlinKilled;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: !merlinKilled ? Colors.green.shade900 : Colors.red.shade900,
      child: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            !merlinKilled
                ? AppLocalizations.of(context)!.merlinSafe
                : AppLocalizations.of(context)!.merlinDead,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
