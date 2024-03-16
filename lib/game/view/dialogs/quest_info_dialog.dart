import 'package:data_repository/data_repository.dart';
import 'package:data_repository/model/model.dart';
import 'package:fluttartur/game/game.dart';
import 'package:fluttartur/widgets/rounded_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> pushQuestInfoDialog(
    BuildContext gameContext, QuestInfoShort questInfo) {
  return showDialog<void>(
      barrierDismissible: false,
      context: gameContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: _DialogContent(questInfo: questInfo),
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

class _DialogContent extends StatelessWidget {
  const _DialogContent({required this.questInfo});

  final QuestInfoShort questInfo;

  @override
  Widget build(BuildContext context) {
    final appearance = QuestTileAppearance.fromStatus(questInfo.status);
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(appearance.iconData),
              Text(
                  "${AppLocalizations.of(context)!.questInfo} #${questInfo.questNumber}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
              Icon(appearance.iconData),
            ],
          ),
          RoundedDivider(
            color: appearance.bgColor,
            thickness: 6,
          ),
          _ShortQuestInfo(questInfo: questInfo),
          questInfo.squadId == null
              ? const SizedBox.shrink()
              : _FullQuestInfo(
                  squadId: questInfo.squadId!,
                ),
        ],
      ),
    );
  }
}

class _ShortQuestInfo extends StatelessWidget {
  const _ShortQuestInfo({required this.questInfo});
  final QuestInfoShort questInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _getQuestStatuusString(context, questInfo.status),
          style: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${AppLocalizations.of(context)!.requiredPlayersNumber}: ",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              questInfo.requiredPlayersNumber.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        !questInfo.isDoubleFail
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.isDoubleFail,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ],
    );
  }
}

class _FullQuestInfo extends StatefulWidget {
  const _FullQuestInfo({required this.squadId});
  final int squadId;

  @override
  State<_FullQuestInfo> createState() => _FullQuestInfoState();
}

class _FullQuestInfoState extends State<_FullQuestInfo> {
  bool isLoading = true;
  QuestInfo loadedInfo = QuestInfo.empty;

  @override
  void initState() {
    super.initState();
    int? squadId = widget.squadId;
    context.read<IDataRepository>().getQuestInfo(squadId: squadId).then(
          (value) => setState(() {
            loadedInfo = loadedInfo;
            isLoading = false;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // leader text

                // members list

                // secret votes
              ],
            ),
          );
  }
}

String _getQuestStatuusString(BuildContext context, QuestStatus status) {
  final localizations = AppLocalizations.of(context)!;

  switch (status) {
    case QuestStatus.upcoming:
      return localizations.questStatus_upcoming;
    case QuestStatus.ongoing:
      return localizations.questStatus_ongoing;
    case QuestStatus.rejected:
      return localizations.questStatus_rejected;
    case QuestStatus.successful:
      return localizations.questStatus_successful;
    case QuestStatus.failed:
      return localizations.questStatus_failed;
    default:
      return localizations.questStatus_error;
  }
}
