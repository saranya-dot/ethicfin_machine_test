part of 'search_bloc.dart';

@freezed
sealed class SearchState with _$SearchState {
  factory SearchState({
    required bool isLoading,
    required bool isError,
    required bool isSuccess,
    required String errorMessage,
    GithubUserModel? user,
    @Default([]) List<String> recentSearches,
  }) = _SearchState;
  factory SearchState.initial() {
    return SearchState(
      errorMessage: '',
      isError: false,
      isLoading: false,
      isSuccess: false,
      user: null,
      recentSearches: const [],
    );
  }
}
