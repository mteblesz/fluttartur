import 'package:data_repository/data_repository.dart';
import 'package:fluttartur/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttartur/matchup/matchup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// tutaj zostały stracone 3 godziny na dojście co jest nie tak z Hero.
// nie działał zupełnie bo w app.dart nie było observera
// teraz nie działa na dole stacka, bo https://github.com/flutter/flutter/issues/17627
//    :(
class MatchupPage extends StatelessWidget {
  const MatchupPage({super.key, required this.isHost});

  static Page<void> page({required bool isHost}) =>
      MaterialPage<void>(child: MatchupPage(isHost: isHost));

  final bool isHost;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            "images/startpagebg.jpg",
            alignment: AlignmentDirectional.centerEnd,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.matchup),
            actions: <Widget>[_MatchupAppBarActions()],
          ),
          body: BlocProvider(
            create: (_) =>
                MatchupCubit(context.read<IDataRepository>(), isHost: isHost),
            child: const MatchupForm(),
          ),
        ),
      ],
    );
  }
}

class _MatchupAppBarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.copyRoomsId),
          onTap: () async {
            final roomId = context.read<IDataRepository>().currentRoomId;
            await Clipboard.setData(ClipboardData(text: roomId.toString()));
          },
        ),
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.leaveRoom),
          onTap: () => context.read<HomeCubit>().leaveMatchup(),
        ),
      ],
    );
  }
}
