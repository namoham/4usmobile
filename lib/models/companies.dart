class Company {
  final int id;
  final String name;
  final String link;

  Company({this.id, this.name, this.link});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['nom'],
      link: json['link'],
    );
  }
}
