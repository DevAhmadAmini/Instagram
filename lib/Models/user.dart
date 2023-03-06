class User {
  final String username;
  final String id;
  final String bio;
  final String photoUrl;
  final String email;
  final List followers;
  final List following;
  final String password;

  User({
    required this.username,
    required this.id,
    required this.bio,
    required this.photoUrl,
    required this.email,
    required this.followers,
    required this.following,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        "password":password,
      };
}
