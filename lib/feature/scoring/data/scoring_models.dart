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
