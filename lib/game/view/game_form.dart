import 'package:data_repository/data_repository.dart';
import 'package:fluttartur/fluttartur_icons_icons.dart';
import 'package:fluttartur/game/cubit/game_cubit.dart';
import 'package:fluttartur/game/cubit/court_cubit.dart';
import 'package:fluttartur/game/view/dialogs/quest_info_dialog.dart';
import 'package:fluttartur/game/view/quest_page/quest_page.dart';
import 'package:fluttartur/home/home.dart';
import 'package:fluttartur/utils/pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttartur/game/view/dialogs/game_dialogs.dart';
import 'package:fluttartur/widgets/widgets.dart';
import '../model/courtier.dart';
import 'dialogs/player_left_dialog.dart';

part 'team_wrap.dart';
part 'game_buttons.dart';
part 'quest_tiles.dart';
part 'rejection_countdown.dart';

class GameForm extends StatefulWidget {
  const GameForm({super.key});
  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  @override
  void initState() {
    super.initState();
    // Show dialog after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pushCharacterInfoDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) => listenGameCubit(context, state),
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            previous.playerLeftGame != current.playerLeftGame,
        listener: (context, state) => listenPlayerLeft(context, state),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _QuestTiles(),
            _RejectionCountdown(),
            Expanded(
              child: _TeamWrap(),
            ),
            //_GameButtons(), // TODO uncomment
          ],
        ),
      ),
    );
  }
}

void listenGameCubit(context, state) {
  switch (state.status) {
    case GameStatus.squadChoice:
      break;
    case GameStatus.squadVoting:
      break;
    case GameStatus.questVoting:
      break;
    case GameStatus.questResults:
      pushQuestResultsDialog(context);
      break;
    case GameStatus.gameResults:
      pushGameResultsDialog(context);
      break;
  }
}

void listenPlayerLeft(context, HomeState state) {
  if (state.playerLeftGame) {
    pushPlayerLeftGameDialog(context, state.message);
  }
}
