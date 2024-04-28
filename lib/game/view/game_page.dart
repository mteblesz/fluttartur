import 'package:fluttartur/game/cubit/game_cubit.dart';
import 'package:fluttartur/game/view/game_form.dart';
import 'package:fluttartur/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttartur/game/view/dialogs/game_dialogs.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: GamePage());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            "images/Accolade.jpg",
            alignment: AlignmentDirectional.center,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.game),
            actions: <Widget>[_GameAppBarActions()],
          ),
          body: BlocProvider(
            create: (_) => GameCubit(context.read<IDataRepository>()),
            child: const GameForm(),
          ),
        ),
      ],
    );
  }
}

class _GameAppBarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text(
            AppLocalizations.of(context)!.forgotRole,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () => pushCharacterInfoDialog(context),
        ),
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.leaveRoom),
          onTap: () => context.read<HomeCubit>().leaveGame(),
        ),
      ],
    );
  }
}
