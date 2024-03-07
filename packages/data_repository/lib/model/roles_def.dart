import 'package:equatable/equatable.dart';

class RolesDef extends Equatable {
  const RolesDef({
    this.hasMerlinAndAssassin = false,
    this.hasPercivalAndMorgana = false,
    this.hasOberonAndMordred = false,
  });
  final bool hasMerlinAndAssassin;
  final bool hasPercivalAndMorgana;
  final bool hasOberonAndMordred;

  @override
  List<Object?> get props => [
        hasMerlinAndAssassin,
        hasPercivalAndMorgana,
        hasOberonAndMordred,
      ];

  RolesDef copyWith(
    bool? hasMerlinAndAssassin,
    bool? hasPercivalAndMorgana,
    bool? hasOberonAndMordred,
  ) {
    return RolesDef(
      hasMerlinAndAssassin: hasMerlinAndAssassin ?? this.hasMerlinAndAssassin,
      hasPercivalAndMorgana:
          hasPercivalAndMorgana ?? this.hasPercivalAndMorgana,
      hasOberonAndMordred: hasOberonAndMordred ?? this.hasOberonAndMordred,
    );
  }
}
