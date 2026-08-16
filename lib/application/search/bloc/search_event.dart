part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started() = _Started;
  const factory SearchEvent.usernameSubmitted(String username) =
      UsernameSubmitted;
  const factory SearchEvent.recentSearchRemoved(String username) =
      RecentSearchRemoved;
  const factory SearchEvent.recentSearchesCleared() = RecentSearchesCleared;
}
