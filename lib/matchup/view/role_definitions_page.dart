import 'package:fluttartur/matchup/cubit/matchup_cubit.dart';
import 'package:fluttartur/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoleDefinitionsPage extends StatelessWidget {
  const RoleDefinitionsPage({super.key});

  /// grants this page access to previous context (of matchup cubit) after push
  static void pushPage(BuildContext parentContext) {
    Navigator.push(
      parentContext,
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<MatchupCubit>(parentContext),
          child: const RoleDefinitionsPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            "images/merlin.png",
            alignment: AlignmentDirectional.center,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.defineRoles),
          ),
          body: _RoleDefinitionsForm(),
        ),
      ],
    );
  }
}

class _RoleDefinitionsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double halfScreenWidth = MediaQuery.of(context).size.width / 2;
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: halfScreenWidth,
              child: const _RoleDefinitionsList(listGood: true),
            ),
            SizedBox(
              width: halfScreenWidth,
              child: const _RoleDefinitionsList(listGood: false),
            ),
          ],
        ),
        Expanded(child: Container()),
        const _RolesDefButtons(),
        const SizedBox(height: 50),
        FilledButton.tonal(
          onPressed: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _RolesDefButtons extends StatelessWidget {
  const _RolesDefButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchupCubit, MatchupState>(
        buildWhen: ((previous, current) =>
            previous.rolesDef != current.rolesDef),
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => !state.rolesDef.hasMerlinAndAssassin
                    ? context.read<MatchupCubit>().addMerlinAndAssassin()
                    : context.read<MatchupCubit>().omitMerlinAndAssassin(),
                child: Text(
                  AppLocalizations.of(context)!.addMerlinAndAssassin,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: !state.rolesDef.hasMerlinAndAssassin
                    ? null
                    : () => !state.rolesDef.hasPercivalAndMorgana
                        ? context.read<MatchupCubit>().addPercivalAndMorgana()
                        : context.read<MatchupCubit>().omitPercivalAndMorgana(),
                child: Text(
                  AppLocalizations.of(context)!.addPercivalAndMorgana,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: !state.rolesDef.hasMerlinAndAssassin
                    ? null
                    : () => !state.rolesDef.hasOberonAndMordred
                        ? context.read<MatchupCubit>().addOberonAndMordred()
                        : context.read<MatchupCubit>().omitOberonAndMordred(),
                child: Text(
                  AppLocalizations.of(context)!.addOberonAndMordred,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        });
  }
}

class _RoleDefinitionsList extends StatelessWidget {
  const _RoleDefinitionsList({
    this.listGood = true,
  });

  final bool listGood;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchupCubit, MatchupState>(
        buildWhen: ((previous, current) =>
            previous.rolesDef != current.rolesDef),
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              OutlinedText(
                listGood
                    ? AppLocalizations.of(context)!.goodRoles
                    : AppLocalizations.of(context)!.evilRoles,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 10),
              !state.rolesDef.hasMerlinAndAssassin
                  ? const SizedBox.shrink()
                  : (listGood
                      ? _TextCard(text: AppLocalizations.of(context)!.merlin)
                      : _TextCard(
                          text: AppLocalizations.of(context)!.assassin)),
              !state.rolesDef.hasPercivalAndMorgana
                  ? const SizedBox.shrink()
                  : (listGood
                      ? _TextCard(text: AppLocalizations.of(context)!.percival)
                      : _TextCard(text: AppLocalizations.of(context)!.morgana)),
              !state.rolesDef.hasOberonAndMordred
                  ? const SizedBox.shrink()
                  : (listGood
                      ? const SizedBox.shrink()
                      : _TextCard(text: AppLocalizations.of(context)!.oberon)),
              !state.rolesDef.hasOberonAndMordred
                  ? const SizedBox.shrink()
                  : (listGood
                      ? const SizedBox.shrink()
                      : _TextCard(text: AppLocalizations.of(context)!.mordred)),
            ],
          );
        });
  }
}

class _TextCard extends StatelessWidget {
  const _TextCard({
    this.text = "",
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
