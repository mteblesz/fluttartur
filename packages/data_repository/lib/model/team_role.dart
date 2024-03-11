import 'package:equatable/equatable.dart';

import 'enums.dart';

class TeamRole extends Equatable {
  final Team team;
  final Role role;

  const TeamRole(this.team, this.role);

  @override
  List<Object?> get props => [team, role];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is TeamRole) {
      return other.team == team && other.role == role;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(team, role);

  static const empty = TeamRole(Team.empty, Role.empty);
  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
}
