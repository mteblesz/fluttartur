import 'package:fluttartur/matchup/matchup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'nick_form.dart';

class MatchupForm extends StatelessWidget {
  const MatchupForm({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => _showNickDialog(context));
    return Column(
      children: [
        __AddPlayerButtonDebug(),
        Expanded(
          child: _PlayerListView(),
        ),
        _HostButtons(),
        const SizedBox(height: 16)
      ],
    );
  }
}

class _PlayerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Player>>(
      stream: context.read<IDataRepository>().streamPlayersList(),
      builder: (context, snapshot) {
        var players = snapshot.data;
        context.read<MatchupCubit>().playerCountChanged(players);
        return players == null
            ? const SizedBox.expand()
            : ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  ...players.map(
                    (player) => _PlayerCard(player: player),
                  ),
                ],
              );
      },
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 0.0),
        title: Text(player.nick),
        trailing: !context.read<MatchupCubit>().isHost
            ? null
            : PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(AppLocalizations.of(context)!.remove),
                    onTap: () =>
                        context.read<MatchupCubit>().removePlayer(player),
                  )
                ],
              ),
      ),
    );
  }
}

class _HostButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return !context.read<MatchupCubit>().isHost
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _RolesDefButton(),
              _StartGameButton(),
            ],
          );
  }
}

class _StartGameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchupCubit, MatchupState>(
        buildWhen: (previous, current) =>
            previous.playersCount != current.playersCount,
        builder: (context, state) {
          return FilledButton(
            onPressed: !context.read<MatchupCubit>().isPlayerCountValid()
                ? null
                : () {
                    context.read<MatchupCubit>().initGame();
                  },
            child: Text(AppLocalizations.of(context)!.startGame,
                style: const TextStyle(fontSize: 20)),
          );
        });
  }
}

class _RolesDefButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () => RoleDefinitionsPage.pushPage(context),
      child: Text(AppLocalizations.of(context)!.roleDefinitionsPage,
          style: const TextStyle(fontSize: 16)),
    );
  }
}

class __AddPlayerButtonDebug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return !kDebugMode
        ? const SizedBox.shrink()
        : ElevatedButton(
            onPressed: () => context.read<MatchupCubit>().addDummyPlayer(),
            child: const Text('Add dummy player'),
          );
  }
}
