class Players {
  String? name;
  int id;
  String? image;
  String? battingStyle;
  String? bowlingStyle;
  Players({
    required this.name,
    required this.id,
    this.image,
    this.battingStyle,
    this.bowlingStyle,
  });

  factory Players.fromJson(json) {
    Players player = Players(
      name: json['user']['name'].toString(),
      id: json['id'],
      image: json['imageUrl'].toString(),
      battingStyle: json['battingStyle'].toString(),
      bowlingStyle: json['bowlingStyle'].toString(),
    );
    return player;
  }
}

class StartMatchExtras {
  List<int> selectedPlayers;
  String teamName;

  StartMatchExtras({
    required this.selectedPlayers,
    required this.teamName,
  });
}

class Team {
  String name;
  int teamId;
  String? image;
  List<Players> players;
  Team({
    required this.name,
    required this.teamId,
    required this.players,
    this.image,
  });

  factory Team.fromJson(json) {
    final teamPlayers = json['players'] as List;

    List<Players> players = teamPlayers
        .map(
          (player) => Players.fromJson(player),
        )
        .toList();

    Team team = Team(
      name: json['name'].toString(),
      teamId: json['id'],
      players: players,
      image: json['imageUrl'].toString(),
    );
    return team;
  }
}

class AddTeamResponse {
  final bool playerExists;
  final bool success;
  final String? message;
  AddTeamResponse({
    required this.playerExists,
    required this.success,
    required this.message,
  });

  factory AddTeamResponse.fromJson(json) {
    AddTeamResponse res = AddTeamResponse(
      playerExists: json['playerExists'],
      success: json['success'],
      message: json['message'],
    );
    return res;
  }
}
