part of 'game_form.dart';

class _GameButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtCubit, CourtState>(
      buildWhen: (previous, current) =>
          previous.squadStatus != current.squadStatus,
      builder: (context, state) {
        if (state.isLeader && state.squadStatus == SquadStatus.squadChoice) {
          return _SubmitSquadButton();
        } else if (state.squadStatus == SquadStatus.submitted) {
          return _VoteSquadPanel();
        } else if (state.squadStatus == SquadStatus.questVoting) {
          return _EmbarkmentCardIfMember();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _SubmitSquadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtCubit, CourtState>(
        buildWhen: (previous, current) =>
            previous.isSquadFull != current.isSquadFull,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FilledButton(
              onPressed: !state.isSquadFull
                  ? null
                  : () => context.read<CourtCubit>().submitSquad(),
              child: Text(AppLocalizations.of(context)!.submitSquad,
                  style: const TextStyle(fontSize: 25)),
            ),
          );
        });
  }
}

class _VoteSquadPanel extends StatefulWidget {
  @override
  State<_VoteSquadPanel> createState() => _VoteSquadPanelState();
}

class _VoteSquadPanelState extends State<_VoteSquadPanel> {
  bool isDisabled = false;

  void _updateIsDisabled(bool newState) {
    setState(() {
      isDisabled = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.voteForThisSquad,
              style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _VoteSquadButton(
                isPositive: true,
                isDisabled: isDisabled,
                updateisDisabled: _updateIsDisabled,
              ),
              _VoteSquadButton(
                isPositive: false,
                isDisabled: isDisabled,
                updateisDisabled: _updateIsDisabled,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _VoteSquadButton extends StatelessWidget {
  const _VoteSquadButton({
    required this.isDisabled,
    required this.updateisDisabled,
    required this.isPositive,
  });

  final bool isDisabled;
  final Function(bool) updateisDisabled;

  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isDisabled
            ? null
            : () {
                context.read<CourtCubit>().voteSquad(isPositive);
                updateisDisabled(!isDisabled);
              },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            isPositive
                ? const Color.fromARGB(255, 60, 188, 202)
                : const Color.fromARGB(255, 130, 34, 203),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              isPositive
                  ? AppLocalizations.of(context)!.accept
                  : AppLocalizations.of(context)!.reject,
              style: const TextStyle(fontSize: 25)),
        ));
  }
}

class _EmbarkmentCardIfMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: context.read<GameCubit>().isCurrentPlayerAMember(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        bool isMember = snapshot.data ?? false;
        return isMember ? _EmbarkmentCard() : const SizedBox.shrink();
      },
    );
  }
}

class _EmbarkmentCard extends StatefulWidget {
  @override
  State<_EmbarkmentCard> createState() => _EmbarkmentCardState();
}

class _EmbarkmentCardState extends State<_EmbarkmentCard> {
  bool _isDisabled = false;

  void _updateIsDisabled(bool newState) {
    // TODO move this to context?
    setState(() {
      _isDisabled = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.thisSquadWasApproved,
                    style: const TextStyle(fontSize: 25)),
              ),
              FilledButton(
                onPressed: _isDisabled
                    ? null
                    : () => Navigator.push(
                        // of context?
                        context,
                        QuestPage.route(() => _updateIsDisabled(true))),
                child: Text(AppLocalizations.of(context)!.embark,
                    style: const TextStyle(fontSize: 30)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
