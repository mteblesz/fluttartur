part of 'game_form.dart';

class _QuestTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(172, 63, 63, 63),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<QuestInfoShort>>(
            stream: context.read<IDataRepository>().streamQuestsSummary(),
            builder: (context, snapshot) {
              var questsSummary = snapshot.data;
              if (questsSummary == null) {
                return const CircularProgressIndicator();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ...questsSummary.map((qi) => _QuestTile(questInfo: qi)),
                ],
              );
            }),
      ),
    );
  }
}

class _QuestTile extends StatelessWidget {
  const _QuestTile({required this.questInfo});

  final QuestInfoShort questInfo;

  @override
  Widget build(BuildContext context) {
    final appearance = _QuestTileAppearance.fromStatus(questInfo.status);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor:
              questInfo.isDoubleFail ? Colors.white : appearance.bgColor,
          child: CircleAvatar(
            radius: 28,
            backgroundColor: appearance.bgColor,
            child: IconButton(
              iconSize: 40,
              color: Colors.white,
              icon: Icon(appearance.iconData),
              onPressed: () {
                // TODO !! quest info
              },
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              questInfo.isDoubleFail ? "Ⅱ" : "",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "${questInfo.requiredPlayersNumber}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuestTileAppearance {
  final Color bgColor;
  final IconData iconData;

  _QuestTileAppearance(this.bgColor, this.iconData);

  factory _QuestTileAppearance.fromStatus(QuestStatus questStatus) {
    switch (questStatus) {
      case QuestStatus.successful:
        return _QuestTileAppearance(
          Colors.green.shade700,
          FluttarturIcons.crown,
        );
      case QuestStatus.failed:
        return _QuestTileAppearance(
          Colors.red.shade700,
          FluttarturIcons.crossed_swords,
        );
      case QuestStatus.ongoing:
        return _QuestTileAppearance(
          const Color.fromARGB(255, 64, 134, 169),
          FluttarturIcons.group,
        );
      case QuestStatus.upcoming:
        return _QuestTileAppearance(
          const Color.fromARGB(255, 13, 66, 110),
          FluttarturIcons.locked_fortress,
        );
      case QuestStatus.rejected: // should not appear in list, equal to error
      case QuestStatus.error:
        return _QuestTileAppearance(
          const Color.fromARGB(255, 35, 35, 35),
          Icons.error_outline,
        );
    }
  }
}
