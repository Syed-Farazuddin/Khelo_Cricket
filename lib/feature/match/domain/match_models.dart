class MatchModels {}

class MatchOverviewModel {
  int? matchId;
  String? state;
  String? ground;
  String? date;
  int? scorerId;
  String? ballType;
  int? tossWonTeamId;
  int? bowlingLimit;
  int? overs;
  int? createdById;
  Innings? firstInnings;
  Innings? secondInnings;
  String? tossResult;
  String? matchStatus;

  MatchOverviewModel({
    this.ballType,
    this.bowlingLimit,
    this.createdById,
    this.date,
    this.firstInnings,
    this.ground,
    this.matchId,
    this.overs,
    this.scorerId,
    this.secondInnings,
    this.tossResult,
    this.matchStatus,
    this.state,
  });

  factory MatchOverviewModel.fromJson(Map<String, dynamic> json) {
    final firstInnings = json['firstInnings'];
    final secondInnings = json['secondInnings'];
    Innings inningsA = Innings.fromJson(firstInnings);
    Innings inningsB = Innings.fromJson(secondInnings);

    return MatchOverviewModel(
      ballType: json['ballType'],
      bowlingLimit: json['bowlingLimit'],
      createdById: json['createdById'],
      date: json['date'],
      ground: json['ground'],
      matchId: json['id'],
      overs: json['overs'],
      firstInnings: inningsA,
      tossResult: json['tossResult'],
      scorerId: json['scorerId'],
      state: json['state'],
      matchStatus: json['matchStatus'],
      secondInnings: inningsB,
    );
  }
}

class Batsmen {
  int? id;
  String? imageUrl;
  int? userId;
  int? statsId;
  String? battingStyle;
  BattingDetails? batting;

  Batsmen({
    required this.batting,
    required this.battingStyle,
    required this.id,
    required this.imageUrl,
    required this.statsId,
    required this.userId,
  });

  factory Batsmen.fromJson(Map<String, dynamic> json) {
    final batting = json['battingSchema'] as List;
    BattingDetails details = BattingDetails(
      bowlerName: '',
      caughtByName: '',
      fours: 0,
      id: 0,
      inningsId: 0,
      isOut: false,
      playerId: 0,
      playerName: '',
      runsScored: [],
      sixes: 0,
      totalRuns: 0,
    );
    if (batting.isNotEmpty) {
      details = BattingDetails.fromJson(batting[0]);
    }
    return Batsmen(
      batting: details,
      battingStyle: json['battingStyle'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      statsId: json['statsId'],
      userId: json['userId'],
    );
  }
}

class Bowler {
  int? id;
  String? bowlingStyle;
  String? battingStyle;
  String? imageUrl;
  int? userId;
  int? statsId;
  List<BowlingDetails>? bowlingDetails;

  Bowler({
    required this.battingStyle,
    required this.bowlingDetails,
    required this.bowlingStyle,
    required this.id,
    required this.imageUrl,
    required this.statsId,
    required this.userId,
  });

  factory Bowler.fromJson(Map<String, dynamic> json) {
    return Bowler(
      battingStyle: json['battingStyle'],
      bowlingDetails: json['bowlingDetails'],
      bowlingStyle: json['bowlingStyle'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      statsId: json['statsId'],
      userId: json['userId'],
    );
  }
}

class BattingDetails {
  int? id;
  String? playerName;
  int? playerId;
  int? inningsId;
  List<int>? runsScored;
  int? totalRuns;
  int? fours;
  int? sixes;
  bool? isOut;
  String? caughtByName;
  String? bowlerName;

  BattingDetails({
    required this.bowlerName,
    required this.caughtByName,
    required this.fours,
    required this.id,
    required this.inningsId,
    required this.isOut,
    required this.playerId,
    required this.playerName,
    required this.runsScored,
    required this.sixes,
    required this.totalRuns,
  });

  factory BattingDetails.fromJson(Map<String, dynamic> json) {
    return BattingDetails(
      bowlerName: json['bowlerName'],
      caughtByName: json['caughtByName'],
      fours: json['fours'],
      id: json['id'],
      inningsId: json['inningsId'],
      isOut: json['isOut'],
      playerId: json['playerId'],
      playerName: json['playerName'],
      runsScored: json['runsScored'],
      sixes: json['sixes'],
      totalRuns: json['totalRuns'],
    );
  }
}

class BowlingDetails {
  int? id;
  int? playerId;
  int? inningsId;
  int? oversBowled;
  int? order;
  bool? isCompleted;
  int? oversLeft;

  BowlingDetails({
    required this.id,
    required this.inningsId,
    required this.isCompleted,
    required this.order,
    required this.oversBowled,
    required this.oversLeft,
    required this.playerId,
  });

  factory BowlingDetails.fromJson(Map<String, dynamic> json) {
    return BowlingDetails(
      id: json['id'],
      inningsId: json['inningsId'],
      isCompleted: json['isCompleted'],
      order: json['order'],
      oversBowled: json['oversBowled'],
      oversLeft: json['oversLeft'],
      playerId: json['playerId'],
    );
  }
}

class Team {
  int? id;
  String? name;
  String? imageUrl;
  int? totalMatches;
  int? wins;
  int? losses;
  int? draws;
  Team({
    required this.draws,
    required this.id,
    required this.imageUrl,
    required this.losses,
    required this.name,
    required this.totalMatches,
    required this.wins,
  });
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      draws: json['team']['draws'],
      id: json['team']['id'],
      imageUrl: json['team']['imageUrl'],
      losses: json['team']['losses'],
      name: json['team']['name'],
      totalMatches: json['team']['totalMatches'],
      wins: json['team']['wins'],
    );
  }
}

class Innings {
  int? id;
  int? totalRuns;
  int? extras;
  int? totalWides;
  int? totalNoBalls;
  int? byes;
  int? oversPlayed;
  bool? isCompleted;
  Team? batting;
  Team? bowling;
  Batsmen? striker;
  Batsmen? nonStriker;
  Bowler? bowler;

  Innings({
    required this.id,
    required this.byes,
    required this.extras,
    required this.isCompleted,
    required this.totalNoBalls,
    required this.striker,
    required this.nonStriker,
    required this.totalWides,
    required this.totalRuns,
    required this.batting,
    required this.oversPlayed,
    required this.bowler,
    required this.bowling,
  });
  factory Innings.fromJson(Map<String, dynamic> json) {
    final stri = json['striker'];
    final nonStri = json['nonStriker'];
    final striker = Batsmen.fromJson(stri);
    final nonStriker = Batsmen.fromJson(nonStri);
    final batTeam = json['batting'];
    final bowlTeam = json['bowling'];
    final batting = Team.fromJson(batTeam[0]);
    final bowling = Team.fromJson(bowlTeam[0]);
    final bowler = Bowler.fromJson(json['bowler']);
    return Innings(
      byes: json['bytes'],
      extras: json['extras'],
      batting: batting,
      bowling: bowling,
      bowler: bowler,
      id: json['id'],
      isCompleted: json['isCompleted'],
      oversPlayed: json['oversPlayed'],
      totalNoBalls: json['totalNoBalls'],
      totalRuns: json['totalRuns'],
      totalWides: json['totalWides'],
      striker: striker,
      nonStriker: nonStriker,
    );
  }
}
