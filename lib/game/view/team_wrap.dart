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
                    child: _SquadListView(),
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
    return BlocBuilder<CourtCubit, CourtState>(
      builder: (context, state) {
        return state.courtiers.isEmpty
            ? Text(AppLocalizations.of(context)!.courtIsEmpty)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...state.courtiers.map(
                    (courtier) => _CourtierCard(
                      courtier: courtier,
                      onCourtierTap: (int id) {
                        if (!courtier.isMember) {
                          context.read<CourtCubit>().addMember(playerId: id);
                        } else {
                          context.read<CourtCubit>().removeMember(playerId: id);
                        }
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class _SquadListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtCubit, CourtState>(
      builder: (context, state) {
        return state.courtiers.isEmpty
            ? Text(AppLocalizations.of(context)!.squadIsEmpty)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ...state.courtiers.where((courtier) => courtier.isMember).map(
                        (courtier) => _CourtierCard(
                          courtier: courtier,
                          onCourtierTap: (int id) {
                            context
                                .read<CourtCubit>()
                                .removeMember(playerId: id);
                          },
                        ),
                      ),
                ],
              );
      },
    );
  }
}

class _CourtierCard extends StatelessWidget {
  const _CourtierCard({
    required this.courtier,
    required this.onCourtierTap,
  });

  final Courtier courtier;
  final void Function(int id) onCourtierTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onCourtierTap(courtier.playerId),
        child: Stack(
          children: [
            Card(
              margin: const EdgeInsets.all(1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    courtier.isLeader
                        ? const Icon(Icons.star)
                        : const SizedBox.shrink(),
                    Flexible(
                      child: Text(
                        courtier.nick,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight:
                              courtier.isCurrentPlayer ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            courtier.isMember
                ? Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }
}
