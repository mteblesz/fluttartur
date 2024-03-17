part of 'game_form.dart';

class _TeamWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedText(AppLocalizations.of(context)!.court,
                    style: const TextStyle(fontSize: 30)),
                Expanded(
                  child: SingleChildScrollView(
                    child: _PlayerListView(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                OutlinedText(AppLocalizations.of(context)!.squad,
                    style: const TextStyle(fontSize: 30)),
                Expanded(
                  child: SingleChildScrollView(
                    child: //_SquadListView(), //TODO uncomment
                        const Text("<members list>"), //TODO remove
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
      future: context.read<IDataRepository>().getPlayers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<Player> players = snapshot.data ?? List.empty();
        return players.isEmpty
            ? const Text("<court is empty>")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...players.map(
                    (player) => _PlayerCard(
                        player: player,
                        isLeader: player.playerId == "" //currentSquad.leaderId,
                        // TODO change bloc above
                        ),
                  ),
                ],
              );
      },
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({required this.player, required this.isLeader});

  final Player player;
  final bool isLeader;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GameCubit>().addMember(player: player),
      child: Card(
        margin: const EdgeInsets.all(1.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isLeader ? const Icon(Icons.star) : const SizedBox.shrink(),
              Flexible(
                child: Text(
                  player.nick,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: player.playerId == 0 //TODO uncomment
                        //context.read<IDataRepository>().currentPlayer.id
                        ? FontWeight.bold
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SquadListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO move curretnsqadid to cubit and make blocbuilder here instead
    return //StreamBuilder<String>(
        //   stream: context.read<IDataRepository>().streamCurrentSquadId(),
        //   builder: (context, snapshot) {
        //     var currentSquadId = snapshot.data;
        //     return currentSquadId == null
        //         ? const Text('<squad is empty>')
        //         :
        StreamBuilder<List<Player>>(
      stream: context.read<GameCubit>().streamMembersList(),
      builder: (context, snapshot) {
        var members = snapshot.data;
        return members == null
            ? const Text('<squad is empty>')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ...members.map(
                    (member) => _MemberCard(member: member),
                  ),
                ],
              );
      },
    );
    //  },
    // );
  }
}

class _MemberCard extends StatelessWidget {
  // TODO ! make it a hero widget between two lists
  const _MemberCard({
    required this.member,
  });

  final Player member;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GameCubit>().removeMember(member: member),
      child: Card(
        margin: const EdgeInsets.all(1.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flexible(
            child: Text(
              member.nick,
              style: TextStyle(
                fontSize: 23,
                fontWeight: member.playerId == 1 //TODO uncomment
                    // context.read<IDataRepository>().currentPlayer.id
                    ? FontWeight.bold
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
