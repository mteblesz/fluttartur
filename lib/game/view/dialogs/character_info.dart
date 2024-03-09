import 'package:data_repository/data_repository.dart';
import 'package:data_repository/model/model.dart';
import 'package:fluttartur/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> pushCharacterInfoDialog(BuildContext gameContext) {
  return showDialog<void>(
      barrierDismissible: false,
      context: gameContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(gameContext)!.yourCharacterIs,
              style: const TextStyle(fontSize: 20)),
          content: _DialogContent(gameContext: gameContext),
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

class _DialogContent extends StatefulWidget {
  const _DialogContent({required this.gameContext});
  final BuildContext gameContext;

  @override
  State<_DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> {
  bool _characterHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Builder(builder: (context) {
          return _characterHidden
              ? const SizedBox.shrink()
              : _TeamRoleInfo(widget: widget);
        }),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() {
            _characterHidden = !_characterHidden;
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _characterHidden
                  ? AppLocalizations.of(context)!.show
                  : AppLocalizations.of(context)!.hide,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        )
      ],
    );
  }
}

class _TeamRoleInfo extends StatelessWidget {
  const _TeamRoleInfo({
    super.key,
    required this.widget,
  });

  final _DialogContent widget;

  @override
  Widget build(BuildContext context) {
    final teamRole = context.read<IDataRepository>().currentTeamRole;
    return Column(
      children: [
        _TeamAndRole(),
        const SizedBox(height: 10),
        !(teamRole.team == Team.evil || teamRole.role == Role.merlin)
            ? const SizedBox.shrink()
            : _InfoForEvilPlayersAndMerlin(widget: widget),
        !(teamRole.role == Role.percival)
            ? const SizedBox.shrink()
            : _InfoForPercival(widget: widget),
      ],
    );
  }
}

class _TeamAndRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teamRole = context.read<IDataRepository>().currentTeamRole;
    final teamString = (teamRole.team) == Team.good
        ? AppLocalizations.of(context)!.good
        : AppLocalizations.of(context)!.evil;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          roleToText(teamRole.role, context),
          style: const TextStyle(fontSize: 25),
        ),
        Text(
          "($teamString)",
          style: const TextStyle(fontSize: 25),
        ),
      ],
    );
  }

  String roleToText(Role role, BuildContext context) {
    switch (role) {
      case Role.merlin:
        return AppLocalizations.of(context)!.merlin;
      case Role.assassin:
        return AppLocalizations.of(context)!.assassin;
      case Role.percival:
        return AppLocalizations.of(context)!.percival;
      case Role.morgana:
        return AppLocalizations.of(context)!.morgana;
      case Role.mordred:
        return AppLocalizations.of(context)!.mordred;
      case Role.oberon:
        return AppLocalizations.of(context)!.oberon;
      case Role.goodKnight:
        return AppLocalizations.of(context)!.goodKnight;
      case Role.evilEntity:
        return AppLocalizations.of(context)!.evilEntity;
      case Role.empty:
        return '__empty__';
      default:
        return 'error';
    }
  }
}

/// info for evil players and merlin
class _InfoForEvilPlayersAndMerlin extends StatelessWidget {
  const _InfoForEvilPlayersAndMerlin({
    super.key,
    required this.widget,
  });

  final _DialogContent widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(widget.gameContext)!.evilCourtiers,
          style: const TextStyle(fontSize: 15),
        ),
        Center(
          child: FutureBuilder<List<Player>>(
            future: widget.gameContext.read<IDataRepository>().getEvilPlayers(),
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
                        style: const TextStyle(fontSize: 13)),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _InfoForPercival extends StatelessWidget {
  const _InfoForPercival({
    super.key,
    required this.widget,
  });

  final _DialogContent widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppLocalizations.of(widget.gameContext)!.merlinAndMorgana,
            style: const TextStyle(fontSize: 15)),
        FutureBuilder<List<Player>>(
          future:
              widget.gameContext.read<IDataRepository>().getMerlinAndMorgana(),
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
                      style: const TextStyle(fontSize: 13)),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
