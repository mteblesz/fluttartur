import 'package:data_repository/data_repository.dart';
import 'package:fluttartur/fluttartur_icons_icons.dart';
import 'package:fluttartur/game/cubit/game_cubit.dart';
import 'package:fluttartur/game/view/dialogs/quest_info_dialog.dart';
import 'package:fluttartur/game/view/quest_page/quest_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttartur/game/view/dialogs/game_dialogs.dart';
import 'package:fluttartur/widgets/widgets.dart';

part 'team_wrap.dart';
part 'game_buttons.dart';
part 'game_quest_tiles.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _QuestTiles(),
          Expanded(
            child: _TeamWrap(),
          ),
          _GameButtons(),
        ],
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
