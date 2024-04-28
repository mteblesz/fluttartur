import 'package:equatable/equatable.dart';

import 'enums.dart';

class Squad extends Equatable {
  final int squadId;
  final int questNumber;
  final SquadStatus status; // remove guys below TODO
  final bool isSubmitted;
  final bool? isApproved;
  final bool? isSuccessfull;
  final Map<String, bool> votes; // attributed by playerId

  const Squad({
    required this.squadId,
    required this.questNumber,
    required this.status,
    required this.isSubmitted,
    this.isApproved,
    this.isSuccessfull,
    required this.votes,
  });

  Squad.init(this.questNumber)
      : squadId = -1,
        status = SquadStatus.unknown,
        isSubmitted = false,
        isApproved = null,
        isSuccessfull = null,
        votes = <String, bool>{};

  /// Empty Squad
  static const empty = Squad(
    squadId: -1,
    questNumber: 0,
    status: SquadStatus.unknown,
    isSubmitted: false,
    isApproved: null,
    isSuccessfull: null,
    votes: <String, bool>{},
  );
  bool get isEmpty => this == Squad.empty;
  bool get isNotEmpty => this != Squad.empty;

  @override
  List<Object?> get props => [
        squadId,
        questNumber,
        status,
        isSubmitted,
        isApproved,
        isSuccessfull,
        votes
      ];
}
