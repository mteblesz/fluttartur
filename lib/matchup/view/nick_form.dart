part of 'matchup_form.dart';

void _showNickDialog(BuildContext context) {
  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return BlocProvider(
        create: (_) => NickFormCubit(
            context.read<IDataRepository>(), AppLocalizations.of(context)!),
        child: _NickDialog(),
      );
    },
  );
}

class _NickDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.enterYourNick),
      content: BlocBuilder<NickFormCubit, NickFormState>(
        buildWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        builder: (context, state) {
          return TextField(
            onChanged: (nick) =>
                context.read<NickFormCubit>().nickChanged(nick),
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.nick,
              errorText: state.errorMessage,
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<NickFormCubit>().setNickname().then((_) {
              if (context
                  .read<NickFormCubit>()
                  .state
                  .status
                  .isSubmissionSuccess) {
                Navigator.of(context).pop();
              }
            });
          },
          child: Text(AppLocalizations.of(context)!.confirm),
        )
      ],
    );
  }
}
