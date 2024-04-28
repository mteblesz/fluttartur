part of 'game_form.dart';

class _RejectionCountdown extends StatelessWidget {
  static List<CircleAppearance> defaultCircleAppearances = [
    CircleAppearance.normal(),
    CircleAppearance.normal(),
    CircleAppearance.normal(),
    CircleAppearance.normal(),
    CircleAppearance.last(),
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(172, 63, 63, 63),
      child: BlocBuilder<CourtCubit, CourtState>(
        builder: (context, state) {
          List<CircleAppearance> circleAppearances = [
            ...List.filled(
                state.prevRejectionCount, CircleAppearance.rejected()),
            ...defaultCircleAppearances.sublist(state.prevRejectionCount)
          ];
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...circleAppearances.map((a) => _RejectionCircle(appearance: a)),
            ],
          );
        },
      ),
    );
  }
}

class _RejectionCircle extends StatelessWidget {
  const _RejectionCircle({required this.appearance});

  final CircleAppearance appearance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        decoration: appearance.hasBorder
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.1,
                ),
              )
            : null,
        child: CircleAvatar(
          radius: appearance.hasBorder ? 8 : 9,
          backgroundColor: appearance.color,
          child: Builder(builder: (context) {
            if (appearance.iconData != null) {
              return Icon(appearance.iconData, size: 15, color: Colors.white);
            }
            // if (number != null && !appearance.hasBorder) {
            //   return Text("$number",
            //       style: const TextStyle(
            //           fontSize: 16,
            //           height: 1.00,
            //           color: Color.fromARGB(255, 37, 37, 37),
            //           fontWeight: FontWeight.bold));
            // }
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}

class CircleAppearance {
  final Color color;
  final IconData? iconData;
  final bool hasBorder;

  const CircleAppearance(this.color, this.iconData, this.hasBorder);

  factory CircleAppearance.rejected() => const CircleAppearance(
        Color.fromARGB(255, 35, 35, 35),
        null,
        true,
      );
  factory CircleAppearance.normal() => CircleAppearance(
        Colors.grey.shade300,
        null,
        false,
      );
  factory CircleAppearance.last() => CircleAppearance(
        Colors.red.shade700,
        FluttarturIcons.crossed_swords,
        false,
      );
}
