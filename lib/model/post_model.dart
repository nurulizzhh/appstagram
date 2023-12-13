class Post {
  dynamic id;
  String username;
  String profile;
  String feed;
  String caption;

  Post({
    required this.id,
    required this.username,
    required this.profile,
    required this.feed,
    required this.caption,
  });
  factory Post.fromJson(Map map) {
    return Post(
        id: map['id'],
        username: map['username'],
        profile: map['profile'],
        feed: map['feed'],
        caption: map['caption']);
  }
}
