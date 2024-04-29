class CastVoteDto {
  final bool value;
  final int squadId;
  final int voterId;

  CastVoteDto({
    required this.value,
    required this.squadId,
    required this.voterId,
  });

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'squadId': squadId,
      'voterId': voterId,
    };
  }
}
