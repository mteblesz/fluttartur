class SquadVoteInfoDto {
  String voterNick;
  bool value;

  SquadVoteInfoDto({
    required this.voterNick,
    required this.value,
  });

  factory SquadVoteInfoDto.fromJson(Map<String, dynamic> json) {
    return SquadVoteInfoDto(
      voterNick: json['voterNick'] ?? "",
      value: json['value'] ?? false,
    );
  }
}
