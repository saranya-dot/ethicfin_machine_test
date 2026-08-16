part of 'repos_bloc.dart';

@freezed
class RepoEvent with _$RepoEvent {
  const factory RepoEvent.fetched(String username) = _Fetched;
  const factory RepoEvent.sortChanged(RepoSortType sortType) = _SortChanged;
}
