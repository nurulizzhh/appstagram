class Account {
  dynamic id;
  String name;
  String email;
  String username;
  String password;
  String profile;
  String bio;

  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.profile,
    required this.bio,
  });
  factory Account.fromJson(Map map) {
    return Account(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        username: map['username'],
        password: map['password'],
        profile: map['profile'],
        bio: map['bio']);
  }
}
