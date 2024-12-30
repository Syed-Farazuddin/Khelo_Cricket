class Match {
  String? startedAt;
  String? tossStatus;
  String? matchStatus;
  String? overs;
  String? scheduledAt;
  int status;
  String state;
  TeamDetails teamA;
  TeamDetails teamB;

  Match({
    required this.state,
    required this.startedAt,
    required this.status,
    required this.matchStatus,
    required this.scheduledAt,
    required this.overs,
    this.tossStatus,
    required this.teamA,
    required this.teamB,
  });

  factory Match.fromJson(json) {
    return Match(
      state: json['state'],
      startedAt: json['startedAt'],
      status: json['status'],
      matchStatus: json['matchStatus'],
      scheduledAt: json['scheduledAt'],
      overs: json['overs'],
      teamA: json['teamA'],
      teamB: json['teamB'],
    );
  }
}

class TeamDetails {
  String name;
  String score;
  String overs;
  String dots;
  String fours;
  String sixes;
  String wickets;
  String status;
  bool won;

  TeamDetails({
    required this.name,
    required this.dots,
    required this.fours,
    required this.overs,
    required this.score,
    required this.sixes,
    required this.status,
    required this.wickets,
    required this.won,
  });
}
