class GithubRepoModel {
  final int id;
  final String name;
  final String? description;
  final int stargazersCount;
  final String? language;
  final String htmlUrl;
  final DateTime? updatedAt;

  GithubRepoModel({
    required this.id,
    required this.name,
    this.description,
    required this.stargazersCount,
    this.language,
    required this.htmlUrl,
    this.updatedAt,
  });

  factory GithubRepoModel.fromMap(Map<String, dynamic> map) {
    return GithubRepoModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'],
      stargazersCount: map['stargazers_count'] ?? 0,
      language: map['language'],
      htmlUrl: map['html_url'] ?? '',
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stargazers_count': stargazersCount,
      'language': language,
      'html_url': htmlUrl,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
