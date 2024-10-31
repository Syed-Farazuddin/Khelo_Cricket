class Players {
  String name;
  int id;
  String image;
  Players({
    required this.name,
    required this.id,
    required this.image,
  });
}

class StartMatchExtras {
  List<int> selectedPlayers;
  String teamName;

  StartMatchExtras({
    required this.selectedPlayers,
    required this.teamName,
  });
}
