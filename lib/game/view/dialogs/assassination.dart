import 'package:data_repository/model/player.dart';
import 'package:fluttartur/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> pushAssassinationDialog(BuildContext gameContext) {
  return showDialog<void>(
      barrierDismissible: false,
      context: gameContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          //title: Text(AppLocalizations.of(gameContext)!.assassination),
          content: _KillingMerlinBox(gameContext: gameContext),
          actions: [
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

class _KillingMerlinBox extends StatelessWidget {
  const _KillingMerlinBox({
    super.key,
    required this.gameContext,
  });

  final BuildContext gameContext;

  @override
  Widget build(BuildContext context) {
    final isAssassin = gameContext.read<GameCubit>().isAssassin();
    return Card(
      color: const Color.fromARGB(118, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: !isAssassin
            ? Column(
                children: [
                  Text(AppLocalizations.of(context)!.assassinChooses,
                      style: const TextStyle(fontSize: 20)),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : Column(
                children: [
                  Text(AppLocalizations.of(context)!.killMerlin,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  FutureBuilder<List<Player>>(
                    future: gameContext.read<GameCubit>().getGoodPlayers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      final goodPlayers = snapshot.data ?? <Player>[];
                      return Wrap(
                        children: [
                          ...goodPlayers.map(
                            (player) => _KillingPlayerButton(
                              player: player,
                              gameContext: gameContext,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class _KillingPlayerButton extends StatelessWidget {
  const _KillingPlayerButton({
    required this.player,
    required this.gameContext,
  });

  final Player player;
  final BuildContext gameContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: FilledButton.tonal(
        onPressed: () =>
            gameContext.read<GameCubit>().killPlayer(playerId: player.playerId),
        child: Text(player.nick),
      ),
    );
  }
}
