class CreatedUserModel {
  final int id;
  final String name;
  final String job;
  final DateTime? createdAt;

  CreatedUserModel(
      {required this.id,
      required this.name,
      required this.job,
      this.createdAt});

  factory CreatedUserModel.fromJson(Map<String, dynamic> json) {
    return CreatedUserModel(
      id: int.tryParse(json['id']) ?? 0,
      name: json['name'],
      job: json['job'],
      createdAt: DateTime.tryParse(json['createdAt']),
    );
  }
}
