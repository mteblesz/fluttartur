import 'package:equatable/equatable.dart';

class Squad extends Equatable {
  final String id;
  final int questNumber;
  final SquadStatus status; // remove guys below TODO
  final bool isSubmitted;
  final bool? isApproved;
  final bool? isSuccessfull;
  final Map<String, bool> votes; // attributed by playerId

  const Squad({
    required this.id,
    required this.questNumber,
    required this.status,
    required this.isSubmitted,
    this.isApproved,
    this.isSuccessfull,
    required this.votes,
  });

  Squad.init(this.questNumber)
      : id = '',
        status = SquadStatus.unknown,
        isSubmitted = false,
        isApproved = null,
        isSuccessfull = null,
        votes = <String, bool>{};

  /// Empty Squad
  static const empty = Squad(
    id: '',
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
  List<Object?> get props =>
      [id, questNumber, status, isSubmitted, isApproved, isSuccessfull, votes];
}

enum SquadStatus {
  unknown,
  squadVoting,
  submitted,
  approved,
  rejected,
  questVoting,
  successfull,
  failed,
}
