import 'dart:async';
import 'package:universal_io/io.dart';
import 'dart:convert';

import 'package:data_repository/data_repository.dart';
import '../dtos/dtos.dart';
import 'api_config.dart';
import 'http_sender.dart';

part 'info_requests.dart';
part 'matchup_requests.dart';
part 'squad_requests.dart';
part 'vote_requests.dart';
part 'kill_requests.dart';

class ApiRepository {
  ApiRepository({required this.getAuthToken});

  final Function() getAuthToken;

  Map<String, String> getAuthHeaders() => <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getAuthToken()}',
      };

  // request methods in extensions segregated 'by-api controller'
}
