import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:fluttartur/home/home.dart';

/// Navigation fork widget
class Home extends StatelessWidget {
  const Home({super.key});

  static Page<void> page() => const MaterialPage<void>(child: Home());

  @override
  Widget build(BuildContext context) {
    final dataRepository = context.read<IDataRepository>();
    return BlocProvider(
      create: (_) => HomeCubit(dataRepository),
      child: Builder(builder: (context) {
        return FlowBuilder<HomeStatus>(
          state: context.select((HomeCubit cubit) => cubit.state.status),
          onGeneratePages: onGenerateRoomViewPages,
        );
      }),
    );
  }
}
