class Post {
  final String description;
  final String username;
  final String photoUrl;
  final String? postPhotoUrl;
  final String userId;
  final String? postId;
  final likes;
  final DateTime datePublished;

  Post({
    required this.datePublished,
    required this.likes,
    required this.postId,
    required this.description,
    required this.username,
    required this.photoUrl,
    required this.postPhotoUrl,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'photoUrl': photoUrl,
      'postPhotoUrl': postPhotoUrl,
      'username': username,
      "postId": postId,
      "likes": [],
      "datePublished": datePublished,
      "userId": userId,
    };
  }
}
