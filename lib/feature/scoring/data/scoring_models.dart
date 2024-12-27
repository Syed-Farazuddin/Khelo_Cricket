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
  int? bowlerId;
  PlayerScoreModel? striker;
  PlayerScoreModel? nonStriker;
  PlayerBowlerScoreModel? bowler;
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
    required this.bowlerId,
    required this.bowler,
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
    PlayerBowlerScoreModel bowler = PlayerBowlerScoreModel(
      player: Players(name: '', id: 0),
      score: BowlingScoreModel(),
    );
    if (json['bowlerId'] != null) {
      final bowlerData = json['bowler'];
      final scoreData = bowlerData['score'];
      final BowlingScoreModel score = BowlingScoreModel.fromJson(scoreData);
      bowler = PlayerBowlerScoreModel(
        player: Players(
          name: bowlerData['user']['name'],
          image: bowlerData['user']['player']['imageUrl'],
          id: bowlerData['user']['player']['id'],
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
      bowlerId: json['bowlerId'],
      bowler: bowler,
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

class PlayerBowlerScoreModel {
  Players? player;
  BowlingScoreModel? score;

  PlayerBowlerScoreModel({
    required this.player,
    required this.score,
  });

  factory PlayerBowlerScoreModel.fromJson(Map<String, dynamic> json) {
    final Players player = Players.fromJson(
      json['user'],
    );
    return PlayerBowlerScoreModel(
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

class BowlingScoreModel {
  bool? isCompleted;
  int? order;
  int? playerId;
  List<List<BallModel>> over;

  BowlingScoreModel({
    this.over = const [],
    this.isCompleted,
    this.order,
    this.playerId,
  });

  factory BowlingScoreModel.fromJson(Map<String, dynamic> json) {
    final List<List<BallModel>> overs = [];
    final List over = json['over'];
    for (int i = 0; i < over.length; i++) {
      final List balls = over[i]['balls'];
      List<BallModel> ball = balls.map((b) => BallModel.fromJson(b)).toList();
      overs.add(ball);
    }
    return BowlingScoreModel(
      isCompleted: json['isCompleted'],
      order: json['order'],
      over: overs,
      playerId: json['playerid'],
    );
  }
}

class BallModel {
  int? id;
  bool? isWide;
  bool? isNoBall;
  bool? isBye;
  bool? isWicket;
  bool? isRunOut;
  int? runs;
  int? playedById;
  int? order;
  int? overId;

  BallModel({
    this.id,
    this.isBye,
    this.isNoBall,
    this.isRunOut,
    this.isWicket,
    this.isWide,
    this.order,
    this.overId,
    this.playedById,
    this.runs,
  });

  factory BallModel.fromJson(Map<String, dynamic> json) {
    return BallModel(
      id: json['id'],
      isBye: json['isBye'],
      isNoBall: json['isNoBall'],
      isRunOut: json['isRunOut'],
      isWicket: json['isWicket'],
      isWide: json['isWide'],
      order: json['order'],
      overId: json['overId'],
      playedById: json['playedById'],
      runs: json['runs'],
    );
  }
}

class UpdateScoringResponse {
  String? message;
  bool? status;
  bool? selectNewBowler;
  bool? endInnings;

  UpdateScoringResponse({
    this.message,
    this.selectNewBowler,
    this.status,
    this.endInnings,
  });

  factory UpdateScoringResponse.fromJson(Map<String, dynamic> json) {
    return UpdateScoringResponse(
      message: json['message'],
      selectNewBowler: json['selectNewBowler'],
      status: json['status'],
      endInnings: json['endInnings'],
    );
  }
}

class DisplayPlayerData {
  MatchData data;
  bool selectbatsman;
  int previousPlayerId;
  Function(Players player) onTap;
  bool showAllPlayers;
  DisplayPlayerData({
    required this.data,
    this.showAllPlayers = false,
    required this.selectbatsman,
    required this.previousPlayerId,
    required this.onTap,
  });
}
