class RegisterTournamentRequest {
  String? name;
  String? imageUrl;
  String? endDate;
  String? startDate;
  String? place;

  RegisterTournamentRequest({
    this.endDate,
    this.imageUrl,
    this.name,
    this.place,
    this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'startDate': startDate,
      'endDate': endDate,
      'place': place,
    };
  }
}
