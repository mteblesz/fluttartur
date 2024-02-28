part of 'matchup_form.dart';

Future<void> _showNickDialog(BuildContext context) {
  return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider(
          create: (_) => NickFormCubit(context.read<IDataRepository>()),
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.enterYourNick),
            content: TextField(
              onChanged: (nick) =>
                  context.read<NickFormCubit>().nickChanged(nick),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.nick,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  //simple validation TODO ! make validation more complex
                  if (!context.read<NickFormCubit>().state.status.isValidated) {
                    return;
                  }
                  final user = context.read<AppBloc>().state.user;
                  context.read<NickFormCubit>().setNickname(user.id);
                  Navigator.of(dialogContext).pop();
                  //context.read<HomeCubit>().subscribeToGameStarted();
                },
                child: Text(AppLocalizations.of(context)!.confirm),
              )
            ],
          ),
        );
      });
}
