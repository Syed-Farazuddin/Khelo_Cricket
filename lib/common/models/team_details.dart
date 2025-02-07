import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';

class TeamDetails {
  int? id;
  String? name;
  String? imageUrl;
  int? totalMatches;
  int? wins;
  int? losses;
  int? draws;
  List<MatchData> matches;
  List<Players> players;

  TeamDetails({
    this.draws,
    this.id,
    this.imageUrl,
    this.losses,
    this.matches = const [],
    this.name,
    this.players = const [],
    this.totalMatches,
    this.wins,
  });

  factory TeamDetails.fromJson(Map<String, dynamic> json) {
    List<Players> players = [];
    final p = json['players'] as List;
    players = p.map((pl) => Players.fromJson(pl)).toList();
    return TeamDetails(
      draws: json['draws'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      players: players,
      losses: json['losses'],
      name: json['name'],
      totalMatches: json['totalMatches'],
      wins: json['wins'],
    );
  }
}
