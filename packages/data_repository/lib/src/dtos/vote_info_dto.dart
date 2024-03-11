import '../../model/model.dart';

class VoteInfoDto {
  String voterNick;
  bool value;

  VoteInfoDto({
    required this.voterNick,
    required this.value,
  });

  factory VoteInfoDto.fromJson(Map<String, dynamic> json) {
    return VoteInfoDto(
      voterNick: json['voterNick'],
      value: json['value'],
    );
  }

  VoteInfo toVoteInfo() {
    return VoteInfo(
      voterNick: voterNick,
      value: value,
    );
  }
}
