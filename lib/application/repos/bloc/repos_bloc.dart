import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saranya_rajagopalan_todo_app/domain/github_repo_model.dart';
import 'package:saranya_rajagopalan_todo_app/domain/repo_sort_type.dart';

import '../../../infrastructure/api_services.dart';

part 'repos_event.dart';
part 'repos_state.dart';
part 'repos_bloc.freezed.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final Apiservices _apiservices;

  RepoBloc({Apiservices? apiservices})
    : _apiservices = apiservices ?? Apiservices(),
      super(RepoState.initial()) {
    on<_Fetched>(_onFetched);
    on<_SortChanged>(_onSortChanged);
  }

  Future<void> _onFetched(_Fetched event, Emitter<RepoState> emit) async {
    emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));

    try {
      final response = await _apiservices.publicGet(
        url: 'https://api.github.com/users/${event.username}/repos',
        queryParameters: {'per_page': 100},
      );

      if (response.statusCode == 200 && response.data is List) {
        final repos = (response.data as List)
            .map((e) => GithubRepoModel.fromMap(Map<String, dynamic>.from(e)))
            .toList();
        emit(state.copyWith(isLoading: false, isError: false, repos: repos));
      } else if (response.statusCode == 404) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: 'User not found',
          ),
        );
      } else if (response.statusCode == 0) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: 'No internet connection. Please try again.',
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: 'Something went wrong. Please try again.',
          ),
        );
      }
    } catch (e) {
      log('$e');
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  void _onSortChanged(_SortChanged event, Emitter<RepoState> emit) {
    emit(state.copyWith(sortType: event.sortType));
  }
}
