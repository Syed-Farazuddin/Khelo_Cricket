class BowlingDetailsModel {
  BowlerDetails? bowlerDetails;
  OverDetails? overDetails;

  BowlingDetailsModel({
    this.bowlerDetails,
    this.overDetails,
  });
}

class BowlerDetails {
  int? id;
  int? inningsId;
  int? oversBowled;
  int? order;
  bool? isCompleted;
  int? bowlingTeamId;
  int? overLeft;

  BowlerDetails({
    this.bowlingTeamId = 0,
    this.id = 0,
    this.inningsId = 0,
    this.isCompleted = false,
    this.order = 0,
    this.overLeft = 0,
    this.oversBowled = 0,
  });

  factory BowlerDetails.fromJson(Map<String, dynamic> json) {
    return BowlerDetails(
      bowlingTeamId: json['bowlingTeamId'] ?? 0,
      id: json['id'],
      inningsId: json['inningsId'],
      isCompleted: json['isCompleted'],
      order: json['order'],
      overLeft: json['overLeft'],
      oversBowled: json['oversBowled'],
    );
  }
}

class OverDetails {
  int? id;
  int? bowlerId;
  int? order;

  OverDetails({
    this.id = 0,
    this.bowlerId = 0,
    this.order = 0,
  });

  factory OverDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    return OverDetails(
      id: json['id'],
      bowlerId: json['bowlerId'],
      order: json['order'],
    );
  }
}
