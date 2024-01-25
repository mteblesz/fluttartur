import 'package:fluttartur/home/home.dart';
import 'package:fluttartur/lobby/cubit/lobby_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fluttartur/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LobbyForm extends StatelessWidget {
  const LobbyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LanguageChangeButton(),
        Expanded(
          child: Align(
            alignment: const Alignment(0, -2 / 3),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 250,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: _RoomIdInput(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _JoinRoomButtonSpace(),
                  const SizedBox(height: 10),
                  _CreateRoomButtonSpace(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoomIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LobbyCubit, LobbyState>(
        buildWhen: (previous, current) => previous.roomId != current.roomId,
        builder: (context, state) {
          return TextField(
            onChanged: (roomId) =>
                context.read<LobbyCubit>().roomIdChanged(roomId),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: AppLocalizations.of(context)!.roomID,
              helperText: '',
              errorText: state.roomId.invalid ? 'invalid room ID' : null,
            ),
          );
        });
  }
}

class _JoinRoomButtonSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LobbyCubit, LobbyState>(
      buildWhen: (previous, current) =>
          previous.statusOfJoin != current.statusOfJoin,
      builder: (context, state) {
        if (state.statusOfJoin.isSubmissionInProgress) {
          return const CircularProgressIndicator();
        }
        if (state.statusOfJoin.isSubmissionFailure) {
          showFailureDialog(context, state.errorMessage);
          return const CircularProgressIndicator();
        }
        if (state.statusOfJoin.isSubmissionSuccess) {
          goToMatchup(context);
          return const CircularProgressIndicator();
        }
        return const _JoinRoomButton();
      },
    );
  }
}

class _JoinRoomButton extends StatelessWidget {
  const _JoinRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        context.read<LobbyCubit>().joinRoom();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(AppLocalizations.of(context)!.join,
            style: const TextStyle(fontSize: 25)),
      ),
    );
  }
}

class _CreateRoomButtonSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LobbyCubit, LobbyState>(
      buildWhen: (previous, current) =>
          previous.statusOfCreate != current.statusOfCreate,
      builder: (context, state) {
        if (state.statusOfCreate.isSubmissionInProgress) {
          return const CircularProgressIndicator();
        }
        if (state.statusOfCreate.isSubmissionFailure) {
          showFailureDialog(context, state.errorMessage);
          return const CircularProgressIndicator();
        }
        if (state.statusOfCreate.isSubmissionSuccess) {
          goToMatchup(context, isHost: true);
          return const CircularProgressIndicator();
        }
        return const _CreateRoomButton();
      },
    );
  }
}

class _CreateRoomButton extends StatelessWidget {
  const _CreateRoomButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () {
        context.read<LobbyCubit>().createRoom();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          AppLocalizations.of(context)!.createRoom,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

void goToMatchup(BuildContext context, {bool isHost = false}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<RoomCubit>().goToMatchup(isHost: isHost);
  });
}

void showFailureDialog(BuildContext parentContext, String errorMessage) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: parentContext,
      builder: (context) => AlertDialog(
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              parentContext.read<LobbyCubit>().resetButtonsState();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  });
}
