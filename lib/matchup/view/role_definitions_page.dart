import 'package:fluttartur/matchup/cubit/matchup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoleDefinitionsPage extends StatelessWidget {
  const RoleDefinitionsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RoleDefinitionsPage(),
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
          body: _RoleDefinitionsView(),
        ),
      ],
    );
  }
}

class _RoleDefinitionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _RoleDefinitionsList(listGood: true),
            SizedBox(width: 10),
            _RoleDefinitionsList(listGood: false),
          ],
        ),
        const Expanded(child: _RolesDefButtons()),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
        const SizedBox(height: 20),
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
                    : context.read<MatchupCubit>().removeMerlinAndAssassin(),
                child: Text(
                  AppLocalizations.of(context)!.addMerlinAndAssassin,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: !state.rolesDef.hasMerlinAndAssassin
                    ? null
                    : () => !state.rolesDef.hasPercivalAndMorgana
                        ? context.read<MatchupCubit>().addPercivalAndMorgana()
                        : context
                            .read<MatchupCubit>()
                            .removePercivalAndMorgana(),
                child: Text(
                  AppLocalizations.of(context)!.addPercivalAndMorgana,
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
              Text(
                listGood
                    ? AppLocalizations.of(context)!.goodColon
                    : AppLocalizations.of(context)!.evilColon,
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
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
