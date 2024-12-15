import 'package:crick_hub/common/models/scoring_models.dart';

class Players {
  String? name;
  int id;
  String? image;
  String? battingStyle;
  String? bowlingStyle;
  bool selected;
  bool isCaptain;
  bool isWicketKeepet;
  Players({
    required this.name,
    required this.id,
    this.image,
    this.battingStyle,
    this.bowlingStyle,
    this.selected = false,
    this.isCaptain = false,
    this.isWicketKeepet = false,
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
  String teamName;
  int teamNo;
  final Future<void> Function() refreshData;
  List<Team> yourTeams;
  StartMatchExtras({
    required this.yourTeams,
    required this.teamName,
    required this.refreshData,
    required this.teamNo,
  });

  Map<String, dynamic> toJson() {
    return {};
  }
}

class Team {
  String name;
  int teamId;
  String? image;
  List<Players> players;
  int selectedAs;
  List<int> selectedPlayers;

  Team({
    required this.name,
    required this.teamId,
    required this.players,
    this.selectedAs = 3,
    required this.selectedPlayers,
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
      selectedPlayers: [],
    );
    return team;
  }
}

class StartMatchRequestBody {
  final int tossWonTeamId;
  final bool chooseToBat;
  final List<int> teams;
  final String ballType;
  final int bowlingLimit;
  final int overs;
  final String ground;
  final String state;
  final String date;
  final List<int> teamAPlayers;
  final List<int> teamBPlayers;

  StartMatchRequestBody({
    required this.date,
    required this.ballType,
    required this.tossWonTeamId,
    required this.chooseToBat,
    required this.teams,
    required this.bowlingLimit,
    required this.overs,
    required this.ground,
    required this.state,
    required this.teamAPlayers,
    required this.teamBPlayers,
  });

  Map<String, dynamic> toJson(StartMatchRequestBody request) {
    return {
      "date": request.date,
      'ballType': request.ballType,
      'tossWonTeamId': request.tossWonTeamId,
      'chooseToBat': request.chooseToBat,
      'teams': request.teams,
      'bowlingLimit': request.bowlingLimit,
      'overs': request.overs,
      'ground': request.ground,
      'state': request.state,
      'teamAPlayers': request.teamAPlayers,
      'teamBPlayers': request.teamBPlayers,
    };
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

class MatchData {
  int? id;
  String? state;
  String? ground;
  String? date;
  String? ballType;
  int? tossWonTeamId;
  bool? chooseToBat;
  bool? chooseToBall;
  int? bowlingLimit;
  int? overs;
  String? createdBy;
  int? inningsA;
  int? inningsB;

  MatchData({
    this.ballType,
    this.bowlingLimit,
    this.chooseToBall,
    this.chooseToBat,
    this.createdBy,
    this.date,
    this.ground,
    this.id,
    this.inningsA,
    this.inningsB,
    this.overs,
    this.state,
    this.tossWonTeamId,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      ballType: json['ballType'],
      bowlingLimit: json['bowlingLimit'],
      chooseToBall: json['chooseToBall'],
      chooseToBat: json['chooseToBat'],
      createdBy: json['createdBy'],
      date: json['date'],
      ground: json['ground'],
      id: json['id'],
      inningsA: json['inningsA'],
      inningsB: json['inningsB'],
      overs: json['overs'],
      state: json['state'],
      tossWonTeamId: json['tossWonTeamId'],
    );
  }

  @override
  String toString() {
    return '''Match Data ( 
    BallType : $ballType , 
    Bowling Limit : $bowlingLimit ,
    ChooseToBat: $chooseToBat ,
    ChooseToball : $chooseToBall ,
    createdBy : $createdBy,
    date : $date,
    ground : $ground , 
    id : $id,
    inningsA : $inningsA,
    inningsB : $inningsB,
    state : $state
    )''';
  }
}

class SelectBowlerReponse {
  BowlerDetails bowler;
  OverDetails over;

  SelectBowlerReponse({
    required this.bowler,
    required this.over,
  });
}
