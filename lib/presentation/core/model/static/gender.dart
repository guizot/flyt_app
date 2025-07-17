class Gender {
  final String id;
  final String name;
  final String icon;

  const Gender({required this.id, required this.name, required this.icon});
}

const List<Gender> genders = [
  Gender(id: "male", name: "Male", icon: "👨"),
  Gender(id: "female", name: "Female", icon: "👩"),
  Gender(id: "other", name: "Other", icon: "⚧️"),
];
