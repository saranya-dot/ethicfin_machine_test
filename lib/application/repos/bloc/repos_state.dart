part of 'repos_bloc.dart';

@freezed
sealed class RepoState with _$RepoState {
  factory RepoState({
    required bool isLoading,
    required bool isError,
    required String errorMessage,
    required List<GithubRepoModel> repos,
    required RepoSortType sortType,
  }) = _RepoState;

  factory RepoState.initial() {
    return RepoState(
      isLoading: false,
      isError: false,
      errorMessage: '',
      repos: const [],
      sortType: RepoSortType.recentlyUpdated,
    );
  }
}

extension RepoStateX on RepoState {
  List<GithubRepoModel> get sortedRepos {
    final sorted = [...repos];
    switch (sortType) {
      case RepoSortType.stars:
        sorted.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
      case RepoSortType.recentlyUpdated:
        sorted.sort((a, b) {
          final aDate = a.updatedAt;
          final bDate = b.updatedAt;
          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return bDate.compareTo(aDate);
        });
    }
    return sorted;
  }
}
