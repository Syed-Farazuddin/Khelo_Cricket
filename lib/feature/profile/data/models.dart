class Stats {
  List<StatsItem> batting;
  List<StatsItem> bowling;
  List<StatsItem> fielding;

  Stats({
    required this.bowling,
    required this.batting,
    required this.fielding,
  });
}

class StatsItem {
  String name;
  String stats;
  StatsItem({
    required this.name,
    required this.stats,
  });
}
