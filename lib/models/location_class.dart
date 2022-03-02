class Location {
  final int id;
  final String name;

  Location({
    required this.id,
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      name: json["name"],
    );
  }

  static List<Location> fromJsonList(List list) {
    return list.map((item) => Location.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return this?.createdAt?.toString()?.contains(filter);
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(Location model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
