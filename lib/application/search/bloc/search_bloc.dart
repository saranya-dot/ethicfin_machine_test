import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saranya_rajagopalan_todo_app/domain/github_user_model.dart';

import '../../../infrastructure/api_services.dart';
import '../../../infrastructure/recent_searches_storage.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Apiservices _apiservices;
  final RecentSearchesStorage _recentSearchesStorage;

  SearchBloc({Apiservices? apiservices, RecentSearchesStorage? recentSearchesStorage})
    : _apiservices = apiservices ?? Apiservices(),
      _recentSearchesStorage = recentSearchesStorage ?? RecentSearchesStorage(),
      super(SearchState.initial()) {
    on<_Started>(_onStarted);
    on<UsernameSubmitted>(_onUsernameSubmitted);
    on<RecentSearchRemoved>(_onRecentSearchRemoved);
    on<RecentSearchesCleared>(_onRecentSearchesCleared);
  }

  void _onStarted(_Started event, Emitter<SearchState> emit) {
    emit(state.copyWith(recentSearches: _recentSearchesStorage.getRecent()));
  }

  Future<void> _onRecentSearchRemoved(
    RecentSearchRemoved event,
    Emitter<SearchState> emit,
  ) async {
    await _recentSearchesStorage.remove(event.username);
    emit(state.copyWith(recentSearches: _recentSearchesStorage.getRecent()));
  }

  Future<void> _onRecentSearchesCleared(
    RecentSearchesCleared event,
    Emitter<SearchState> emit,
  ) async {
    await _recentSearchesStorage.clear();
    emit(state.copyWith(recentSearches: _recentSearchesStorage.getRecent()));
  }

  Future<void> _onUsernameSubmitted(
    UsernameSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    final username = event.username.trim();
    if (username.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          errorMessage: 'Please enter a username',
          user: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        isSuccess: false,
        errorMessage: '',
      ),
    );

    try {
      final response = await _apiservices.publicGet(
        url: 'https://api.github.com/users/$username',
      );

      if (response.statusCode == 200 && response.data is Map) {
        final user = GithubUserModel.fromMap(
          Map<String, dynamic>.from(response.data as Map),
        );
        await _recentSearchesStorage.add(username);
        emit(
          state.copyWith(
            isLoading: false,
            isError: false,
            isSuccess: true,
            errorMessage: '',
            user: user,
            recentSearches: _recentSearchesStorage.getRecent(),
          ),
        );
      } else if (response.statusCode == 404) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            isSuccess: false,
            errorMessage: 'User not found',
            user: null,
          ),
        );
      } else if (response.statusCode == 0) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            isSuccess: false,
            errorMessage: 'No internet connection. Please try again.',
            user: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            isSuccess: false,
            errorMessage: 'Something went wrong. Please try again.',
            user: null,
          ),
        );
      }
    } catch (e) {
      log('$e');
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          errorMessage: 'Something went wrong. Please try again.',
          user: null,
        ),
      );
    }
  }
}
