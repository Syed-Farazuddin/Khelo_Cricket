class StatsItem {
  String name;
  String stats;
  StatsItem({
    required this.name,
    required this.stats,
  });

  factory StatsItem.fromJson(json) {
    return StatsItem(
      name: json['name'],
      stats: json['value'].toString(),
    );
  }
}

class PlayerStats {
  List<List<StatsItem>> stats;
  PlayerStats({
    required this.stats,
  });
}

class ProfileInfo {
  String? name;
  String? age;
  String? dob;
  String? number;
  PlayerStats stats;
  ProfileInfo({
    required this.stats,
    this.age,
    this.dob,
    this.name,
    this.number,
  });
  factory ProfileInfo.fromJson(json) {
    final List<dynamic> list1 = json['battingStats'] as List;

    final List<StatsItem> battingStats = list1.map(
      (json) {
        return StatsItem.fromJson(
          json,
        );
      },
    ).toList();

    final List<dynamic> list2 = json['fieldingStats'];
    final List<StatsItem> fieldingStats = list2.map(
      (json) {
        return StatsItem.fromJson(
          json,
        );
      },
    ).toList();
    final List<dynamic> list3 = json['bowlingStats'];
    final List<StatsItem> bowlingStats = list3.map(
      (json) {
        return StatsItem.fromJson(
          json,
        );
      },
    ).toList();
    return ProfileInfo(
      age: json['age'].toString(),
      dob: json['dob'],
      name: json['name'],
      number: json['mobile'],
      stats: PlayerStats(
        stats: [battingStats, bowlingStats, fieldingStats],
      ),
    );
  }
}
