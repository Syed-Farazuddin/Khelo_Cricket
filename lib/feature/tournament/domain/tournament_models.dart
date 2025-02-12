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
  List<Team> teams;
  List<MatchData> matches;
  String? name;
  int? id;
  String? place;
  String? startDate;
  String? endDate;
  String? imageUrl;
  bool? openForAll;
  bool? registrationsOpen;
  int? createdById;

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
    this.createdById,
  });

  factory TournamentData.fromJson(Map<String, dynamic> json) {
    List<MatchData> matches = [];
    List<Team> registeredTeams = [];
    final teams = json['registeredTeams'] as List;
    registeredTeams = teams.map((t) => Team.fromJson(t)).toList();
    return TournamentData(
      name: json['name'],
      id: json['id'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      imageUrl: json['imageUrl'],
      createdById: json['createdBy']['id'],
      matches: matches,
      registrationsOpen: json['registrationsOpen'],
      openForAll: json['openForAll'],
      place: json['place'],
      teams: registeredTeams,
    );
  }
}
