import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';

class Updatescoring {
  int? ball;
  int? runs;
  bool? isWide;
  bool? isBye;
  bool? isNoBall;
  bool? isRunOut;
  bool? isWicket;
  int? bowlerId;
  int? overId;

  Updatescoring({
    required this.ball,
    required this.runs,
    required this.isWide,
    required this.isBye,
    required this.isNoBall,
    required this.isRunOut,
    required this.isWicket,
    required this.bowlerId,
    required this.overId,
  });

  Map<String, dynamic> toJson(Updatescoring score) {
    return {
      'ball': score.ball,
      'runs': score.runs,
      'isWide': score.isWide,
      'isBye': score.isBye,
      'isNoBall': score.isNoBall,
      'isRunOut': score.isRunOut,
      'isWicket': score.isWicket,
      'bowlerId': score.bowlerId,
      'overId': score.overId
    };
  }
}

class InningsModel {
  int? inningsid;
  int? totalRuns;
  int? extras;
  int? totalWides;
  int? totalNoBalls;
  int? byes;
  int? oversPlayed;
  bool? isCompleted;
  int? nonStrikerId;
  int? strikerId;
  PlayerScoreModel? striker;
  PlayerScoreModel? nonStriker;

  InningsModel({
    required this.byes,
    required this.extras,
    required this.inningsid,
    required this.isCompleted,
    required this.nonStrikerId,
    required this.oversPlayed,
    required this.strikerId,
    required this.totalNoBalls,
    required this.totalRuns,
    required this.totalWides,
    required this.nonStriker,
    required this.striker,
  });

  factory InningsModel.fromJson(Map<String, dynamic> json) {
    PlayerScoreModel striker = PlayerScoreModel(
      player: Players(name: '', id: 0),
      score: ScoreModel(),
    );
    if (json['strikerId'] != null) {
      final strikerData = json['striker'];
      final scoreData = strikerData['score'];
      final ScoreModel score = ScoreModel.fromJson(scoreData);
      striker = PlayerScoreModel(
        player: Players(
          name: strikerData['user']['name'],
          image: strikerData['user']['player']['imageUrl'],
          id: strikerData['user']['player']['id'],
        ),
        score: score,
      );
    }
    PlayerScoreModel nonStriker = PlayerScoreModel(
      player: Players(name: '', id: 0),
      score: ScoreModel(),
    );

    if (json['nonStrikerId'] != null) {
      final nonStrikerData = json['nonStriker'];
      final scoreData = nonStrikerData['score'];
      final ScoreModel score = ScoreModel.fromJson(scoreData);
      nonStriker = PlayerScoreModel(
        player: Players(
          name: nonStrikerData['user']['name'],
          image: nonStrikerData['user']['player']['imageUrl'],
          id: nonStrikerData['user']['player']['id'],
        ),
        score: score,
      );
    }
    return InningsModel(
      byes: json['bytes'],
      extras: json['extras'],
      inningsid: json['id'],
      isCompleted: json['isCompleted'],
      nonStrikerId: json['nonStrikerId'],
      oversPlayed: json['oversPlayed'],
      strikerId: json['strikerId'],
      totalNoBalls: json['totalNoBalls'],
      totalRuns: json['totalRuns'],
      totalWides: json['totalWides'],
      striker: striker,
      nonStriker: nonStriker,
    );
  }
}

class PlayerScoreModel {
  Players? player;
  ScoreModel? score;

  PlayerScoreModel({
    required this.player,
    required this.score,
  });

  factory PlayerScoreModel.fromJson(Map<String, dynamic> json) {
    final Players player = Players.fromJson(
      json['user'],
    );
    return PlayerScoreModel(
      player: player,
      score: json['score'],
    );
  }
}

class ScoreModel {
  int? id;
  String? playerName;
  int? totalRuns;
  List<dynamic>? runsScores;
  int? inningsId;
  int? playerId;
  int? fours;
  int? sixes;
  bool? isOut;
  int? battingTeamId;
  String? caughtByName;
  String? bowlerName;

  ScoreModel({
    this.battingTeamId,
    this.bowlerName,
    this.caughtByName,
    this.fours,
    this.id,
    this.inningsId,
    this.isOut,
    this.playerId,
    this.playerName,
    this.runsScores,
    this.sixes,
    this.totalRuns,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    List scores = json['runsScores'];
    return ScoreModel(
      battingTeamId: json['battingTeamId'],
      bowlerName: json['bowlerName'],
      caughtByName: json['caughtByName'],
      fours: json['fours'],
      id: json['id'],
      inningsId: json['inningsid'],
      isOut: json['isOut'],
      playerId: json['playerId'],
      playerName: json['playerName'],
      runsScores: scores,
      sixes: json['sixes'],
      totalRuns: json['totalRuns'],
    );
  }
}
