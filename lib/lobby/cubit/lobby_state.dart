part of 'lobby_cubit.dart';

class LobbyState extends Equatable {
  const LobbyState({
    this.roomId = const RoomId.pure(),
    this.statusOfJoin = FormzStatus.pure,
    this.statusOfCreate = FormzStatus.pure,
    this.errorMessage = "",
  });

  final RoomId roomId;
  final FormzStatus statusOfJoin;
  final FormzStatus statusOfCreate;
  final String errorMessage;

  @override
  List<Object> get props =>
      [roomId, statusOfJoin, statusOfCreate, errorMessage];

  LobbyState copyWith({
    RoomId? roomId,
    FormzStatus? statusOfJoin,
    FormzStatus? statusOfCreate,
    String? errorMessage,
  }) {
    return LobbyState(
      roomId: roomId ?? this.roomId,
      statusOfJoin: statusOfJoin ?? this.statusOfJoin,
      statusOfCreate: statusOfCreate ?? this.statusOfCreate,
      errorMessage: errorMessage ?? "", // empty by default
    );
  }
}
