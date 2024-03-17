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
    final dividerColor =
        QuestTileAppearance.fromStatus(questInfo.status).bgColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(QuestTileAppearance.fromStatus(questInfo.status).iconData),
            Text(
                "${AppLocalizations.of(context)!.questInfo} #${questInfo.questNumber}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )),
            Icon(QuestTileAppearance.fromStatus(questInfo.status).iconData),
          ],
        ),
        RoundedDivider(
          padding: const EdgeInsets.all(8.0),
          color: dividerColor,
          thickness: 6,
        ),
        questInfo.squadId == null
            ? _ShortQuestInfo(questInfo: questInfo)
            :
            // weird setup below  Expanded -> SingleChildScrollView
            // allows to scroll contents without scrolling children above
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ShortQuestInfo(questInfo: questInfo),
                      _FullQuestInfo(
                        squadId: questInfo.squadId!,
                        dividerColor: dividerColor,
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}

class _ShortQuestInfo extends StatelessWidget {
  const _ShortQuestInfo({required this.questInfo});
  final QuestInfoShort questInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _getQuestStatusString(context, questInfo.status),
          style: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
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
                  "* ${AppLocalizations.of(context)!.isDoubleFail} *",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
      ],
    );
  }
}

class _FullQuestInfo extends StatefulWidget {
  const _FullQuestInfo({required this.squadId, required this.dividerColor});
  final int squadId;
  final Color dividerColor;

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
            children: [
              _SmallDivider(color: widget.dividerColor),
              loadedInfo.questVoteSuccessCount == null
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        _QuestOutcome(
                          loadedInfo: loadedInfo,
                        ),
                        _SmallDivider(color: widget.dividerColor),
                      ],
                    ),
              _SquadLine(loadedInfo: loadedInfo),
              _SmallDivider(color: widget.dividerColor),
              _SquadVotingOutcome(loadedInfo: loadedInfo),
            ],
          );
  }
}

class _SmallDivider extends StatelessWidget {
  const _SmallDivider({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RoundedDivider(
      padding: const EdgeInsets.all(8.0),
      color: color,
      thickness: 3,
    );
  }
}

String _getQuestStatusString(BuildContext context, QuestStatus status) {
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

class _QuestOutcome extends StatelessWidget {
  const _QuestOutcome({required this.loadedInfo});
  final QuestInfo loadedInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${AppLocalizations.of(context)!.questVotes}: ",
          style: const TextStyle(fontSize: 18),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ..._getSecretVotesCardsLine(loadedInfo.requiredPlayersNumber,
                loadedInfo.questVoteSuccessCount!),
          ],
        ),
      ],
    );
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
      color: value ? Colors.green.shade700 : Colors.red.shade700,
      child: SizedBox(
        height: 50,
        width: 37,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            value ? FluttarturIcons.crown : FluttarturIcons.crossed_swords,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _SquadLine extends StatelessWidget {
  const _SquadLine({required this.loadedInfo});
  final QuestInfo loadedInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${AppLocalizations.of(context)!.leader}:  ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.star, size: 20),
            Text(
              " ${loadedInfo.leader.nick}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "${AppLocalizations.of(context)!.squad} ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ...loadedInfo.members.map((member) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(member.nick),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SquadVotingOutcome extends StatelessWidget {
  const _SquadVotingOutcome({required this.loadedInfo});
  final QuestInfo loadedInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${AppLocalizations.of(context)!.squadVotingInfo}: ",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        _SquadAcceptanceVoters(
          showPositiveVotes: true,
          squadVoteInfos: loadedInfo.squadVoteInfo,
        ),
        const SizedBox(height: 10),
        _SquadAcceptanceVoters(
          showPositiveVotes: false,
          squadVoteInfos: loadedInfo.squadVoteInfo,
        ),
      ],
    );
  }
}

class _SquadAcceptanceVoters extends StatelessWidget {
  const _SquadAcceptanceVoters({
    required this.showPositiveVotes,
    required this.squadVoteInfos,
  });
  final bool showPositiveVotes;
  final List<VoteInfo> squadVoteInfos;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showPositiveVotes
            ? const Icon(
                Icons.thumb_up,
                size: 25,
                color: Color.fromARGB(255, 60, 188, 202),
              )
            : const Icon(
                Icons.thumb_down,
                size: 25,
                color: Color.fromARGB(255, 130, 34, 203),
              ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ...squadVoteInfos
                  .where((vote) => vote.value == showPositiveVotes)
                  .map((vote) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(vote.voterNick),
                      )),
            ],
          ),
        ),
      ],
    );
  }
}
