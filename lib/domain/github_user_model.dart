class GithubUserModel {
  final int id;
  final String login;
  final String? name;
  final String? bio;
  final String avatarUrl;
  final String htmlUrl;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? twitterUsername;
  final int followers;
  final int following;
  final int publicRepos;
  final int publicGists;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GithubUserModel({
    required this.id,
    required this.login,
    this.name,
    this.bio,
    required this.avatarUrl,
    required this.htmlUrl,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.twitterUsername,
    required this.followers,
    required this.following,
    required this.publicRepos,
    required this.publicGists,
    this.createdAt,
    this.updatedAt,
  });

  factory GithubUserModel.fromMap(Map<String, dynamic> map) {
    return GithubUserModel(
      id: map['id'] ?? 0,
      login: map['login'] ?? '',
      name: map['name'],
      bio: map['bio'],
      avatarUrl: map['avatar_url'] ?? '',
      htmlUrl: map['html_url'] ?? '',
      company: map['company'],
      blog: (map['blog'] as String?)?.isEmpty ?? true ? null : map['blog'],
      location: map['location'],
      email: map['email'],
      twitterUsername: map['twitter_username'],
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
      publicRepos: map['public_repos'] ?? 0,
      publicGists: map['public_gists'] ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'name': name,
      'bio': bio,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'company': company,
      'blog': blog,
      'location': location,
      'email': email,
      'twitter_username': twitterUsername,
      'followers': followers,
      'following': following,
      'public_repos': publicRepos,
      'public_gists': publicGists,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
