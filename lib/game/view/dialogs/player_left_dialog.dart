import 'package:fluttartur/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> pushPlayerLeftGameDialog(
    BuildContext gameContext, String afkPlayerNick) {
  return showDialog<void>(
      barrierDismissible: false,
      context: gameContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Text("$afkPlayerNick "),
              Text(
                AppLocalizations.of(gameContext)!.playerLeft,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                gameContext.read<HomeCubit>().resetPlayerLeftGameFlag();
                Navigator.of(dialogContext).pop();
                gameContext.read<HomeCubit>().leaveGame();
              },
              child: Text(AppLocalizations.of(gameContext)!.leaveRoom,
                  style: const TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                gameContext.read<HomeCubit>().resetPlayerLeftGameFlag();
                Navigator.of(dialogContext).pop();
              },
              child: Text(AppLocalizations.of(gameContext)!.closeInfo,
                  style: const TextStyle(fontSize: 20)),
            ),
          ],
        );
      });
}
