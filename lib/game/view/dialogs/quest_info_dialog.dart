import 'package:data_repository/data_repository.dart';
import 'package:data_repository/model/model.dart';
import 'package:fluttartur/game/game.dart';
import 'package:fluttartur/widgets/rounded_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttartur/fluttartur_icons_icons.dart';

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
          SingleChildScrollView(
            child: Column(
              children: [
                _ShortQuestInfo(questInfo: questInfo),
                questInfo.squadId == null
                    ? const SizedBox.shrink()
                    : _FullQuestInfo(
                        squadId: questInfo.squadId!,
                      ),
              ],
            ),
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
        ? const CircularProgressIndicator()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // quest votes
              loadedInfo.questVoteSuccessCount == null
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text(
                                "${AppLocalizations.of(context)!.questVotes}: "),
                            ..._getSecretVotesCardsLine(
                                loadedInfo.requiredPlayersNumber,
                                loadedInfo.questVoteSuccessCount!),
                          ],
                        ),
                        loadedInfo.status == QuestStatus.successful
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  Text(AppLocalizations.of(context)!.success),
                                ],
                              ),
                        loadedInfo.status == QuestStatus.failed
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  Text(AppLocalizations.of(context)!.fail),
                                ],
                              ),
                      ],
                    ),

              // leader text
              Text(
                "${AppLocalizations.of(context)!.leader}: ${loadedInfo.leader.nick}",
              ),

              // members list
              Wrap(children: <Widget>[
                Text("${AppLocalizations.of(context)!.squad} "),
                ...loadedInfo.members.map((member) => Text(member.nick)),
              ]),

              // squad votes
              Text("${AppLocalizations.of(context)!.squadVotingInfo} "),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.thumb_up,
                          color: Color.fromARGB(255, 60, 188, 202)),
                      ...loadedInfo.squadVoteInfo
                          .where((vote) => vote.value == true)
                          .map((vote) => Text(vote.voterNick)),
                    ],
                  ),
                  const Divider(),
                  Column(
                    children: [
                      const Icon(Icons.thumb_down,
                          color: Color.fromARGB(255, 130, 34, 203)),
                      ...loadedInfo.squadVoteInfo
                          .where((vote) => vote.value == false)
                          .map((vote) => Text(vote.voterNick)),
                    ],
                  ),
                ],
              ),
            ],
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

List<Widget> _getSecretVotesCardsLine(int membersCount, int successCount) {
  final List<Widget> cards = [];
  for (int i = 0; i < successCount; i++) {
    cards.add(const _VoteCard(value: true));
  }
  for (int i = 0; i < membersCount - successCount; i++) {
    cards.add(const _VoteCard(value: false));
  }
  cards.shuffle();
  return cards;
}

class _VoteCard extends StatelessWidget {
  const _VoteCard({required this.value});
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          value ? FluttarturIcons.crown : FluttarturIcons.crossed_swords,
          color: value ? Colors.green.shade50 : Colors.red.shade700,
        ),
      ),
    );
  }
}
