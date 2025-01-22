import 'package:crick_hub/common/models/scoring_models.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';

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
  int? wides;
  int? runs;
  int? dots;
  int? noBalls;
  int? wickets;
  List<OverDetails> over;

  BowlingDetails({
    required this.id,
    required this.inningsId,
    required this.isCompleted,
    required this.order,
    required this.oversBowled,
    required this.oversLeft,
    required this.playerId,
    required this.dots,
    required this.noBalls,
    required this.over,
    required this.runs,
    required this.wickets,
    required this.wides,
  });

  factory BowlingDetails.fromJson(Map<String, dynamic> json) {
    final overDetails = json['over'] as List;
    List<OverDetails> overs =
        overDetails.map((over) => OverDetails.fromJson(over, true)).toList();
    return BowlingDetails(
      id: json['id'],
      inningsId: json['inningsId'],
      isCompleted: json['isCompleted'],
      order: json['order'],
      oversBowled: json['oversBowled'],
      oversLeft: json['oversLeft'],
      playerId: json['playerId'],
      dots: json['dots'],
      noBalls: json['noBalls'],
      runs: json['runs'],
      wickets: json['wickets'],
      wides: json['wides'],
      over: overs,
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
  List<BattingDetails> batmens;
  List<BowlingDetails> bowlers;
  List<Players> playing;
  Team({
    required this.draws,
    required this.id,
    required this.imageUrl,
    required this.losses,
    required this.name,
    required this.batmens,
    required this.playing,
    required this.totalMatches,
    required this.wins,
    required this.bowlers,
  });

  factory Team.fromJson({
    required Map<String, dynamic> json,
    required bool batting,
  }) {
    List<BattingDetails> batsmens = [];
    List<BowlingDetails> bowlers = [];
    List<Players> playing11 = [];
    if (batting) {
      final batmen = json['batmens'] as List;
      batsmens = batmen.map((json) => BattingDetails.fromJson(json)).toList();
    } else {
      final bowler = json['bowlers'] as List;
      bowlers = bowler.map((json) => BowlingDetails.fromJson(json)).toList();
    }
    final playing = json['playing11'] as List;
    playing11 = playing.map((p) => Players.fromJson(p)).toList();
    return Team(
      draws: json['team']['draws'],
      playing: playing11,
      id: json['team']['id'],
      imageUrl: json['team']['imageUrl'],
      losses: json['team']['losses'],
      name: json['team']['name'],
      totalMatches: json['team']['totalMatches'],
      wins: json['team']['wins'],
      batmens: batsmens,
      bowlers: bowlers,
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
  int? wickets;
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
    required this.wickets,
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
    final batting = Team.fromJson(
      json: batTeam[0],
      batting: true,
    );
    final bowling = Team.fromJson(
      json: bowlTeam[0],
      batting: false,
    );
    final bowler = Bowler.fromJson(json['bowler']);

    return Innings(
      byes: json['bytes'],
      wickets: json['wickets'],
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
