part of 'api_repository.dart';

extension InfoRequests on ApiRepository {
  Future<Room> getRoomById(int roomId) async {
    final response = await HttpSender.get(
      Uri.parse(ApiConfig.getRoomByIdUrl(roomId)),
      headers: getAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw GetRoomFailure(response.statusCode, response.body);
    }
    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    return RoomInfoDto.fromJson(jsonBody).toRoom();
  }
}
