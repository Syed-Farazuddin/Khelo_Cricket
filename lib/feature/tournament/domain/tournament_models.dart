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
  int? id;
  String? place;
  String? startDate;
  String? endDate;
  String? imageUrl;
  bool? openForAll;
  bool? registrationsOpen;

  TournamentData({
    this.endDate,
    this.imageUrl,
    this.id,
    this.matches = const [],
    this.teams = const [],
    this.name,
    this.openForAll,
    this.place,
    this.registrationsOpen,
    this.startDate,
  });

  factory TournamentData.fromJson(Map<String, dynamic> json) {
    List<MatchData> matches = [];
    List<TeamData> registeredTeams = [];
    return TournamentData(
      name: json['name'],
      id: json['id'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      imageUrl: json['imageUrl'],
      matches: matches,
      registrationsOpen: json['registrationsOpen'],
      openForAll: json['openForAll'],
      place: json['place'],
      teams: registeredTeams,
    );
  }
}
