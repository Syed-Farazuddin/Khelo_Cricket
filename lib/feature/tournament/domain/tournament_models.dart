import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';

class RegisterTournamentRequest {
  String? name;
  String? imageUrl;
  String? endDate;
  String? startDate;
  String? place;
  bool? openForAll;
  bool? registrationsOpen;

  RegisterTournamentRequest({
    this.endDate,
    this.imageUrl,
    this.name,
    this.place,
    this.openForAll,
    this.registrationsOpen,
    this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'startDate': startDate,
      'endDate': endDate,
      'place': place,
      'openForAll': openForAll,
      'registrationsOpen': registrationsOpen,
    };
  }
}

class TournamentData {
  List<TeamData> teams;
  List<MatchData> matches;
  String? name;
  String? place;
  String? startDate;
  String? endDate;
  String? imageUrl;
  bool? openForAll;
  bool? registrationsOpen;

  TournamentData({
    this.endDate,
    this.imageUrl,
    this.matches = const [],
    this.teams = const [],
    this.name,
    this.openForAll,
    this.place,
    this.registrationsOpen,
    this.startDate,
  });
}
