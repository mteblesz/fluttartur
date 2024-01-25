import 'package:equatable/equatable.dart';

class Squad extends Equatable {
  final String id;
  final int questNumber;
  final bool isSubmitted;
  final bool? isApproved;
  final bool? isSuccessfull;
  final Map<String, bool> votes; // atributed by playerId

  const Squad({
    required this.id,
    required this.questNumber,
    required this.isSubmitted,
    this.isApproved,
    this.isSuccessfull,
    required this.votes,
  });

  Squad.init(this.questNumber)
      : id = '',
        isSubmitted = false,
        isApproved = null,
        isSuccessfull = null,
        votes = <String, bool>{};

  /// Empty Squad
  static const empty = Squad(
    id: '',
    questNumber: 0,
    isSubmitted: false,
    isApproved: null,
    isSuccessfull: null,
    votes: <String, bool>{},
  );

  /// Convenience getter to determine whether the current Squad is empty.
  bool get isEmpty => this == Squad.empty;

  /// Convenience getter to determine whether the current Squad is not empty.
  bool get isNotEmpty => this != Squad.empty;

  @override
  List<Object?> get props =>
      [id, questNumber, isSubmitted, isApproved, isSuccessfull, votes];
}
