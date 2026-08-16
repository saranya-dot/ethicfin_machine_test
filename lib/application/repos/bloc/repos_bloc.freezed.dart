// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repos_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RepoEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepoEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RepoEvent()';
}


}

/// @nodoc
class $RepoEventCopyWith<$Res>  {
$RepoEventCopyWith(RepoEvent _, $Res Function(RepoEvent) __);
}


/// Adds pattern-matching-related methods to [RepoEvent].
extension RepoEventPatterns on RepoEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Fetched value)?  fetched,TResult Function( _SortChanged value)?  sortChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Fetched() when fetched != null:
return fetched(_that);case _SortChanged() when sortChanged != null:
return sortChanged(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Fetched value)  fetched,required TResult Function( _SortChanged value)  sortChanged,}){
final _that = this;
switch (_that) {
case _Fetched():
return fetched(_that);case _SortChanged():
return sortChanged(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Fetched value)?  fetched,TResult? Function( _SortChanged value)?  sortChanged,}){
final _that = this;
switch (_that) {
case _Fetched() when fetched != null:
return fetched(_that);case _SortChanged() when sortChanged != null:
return sortChanged(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String username)?  fetched,TResult Function( RepoSortType sortType)?  sortChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Fetched() when fetched != null:
return fetched(_that.username);case _SortChanged() when sortChanged != null:
return sortChanged(_that.sortType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String username)  fetched,required TResult Function( RepoSortType sortType)  sortChanged,}) {final _that = this;
switch (_that) {
case _Fetched():
return fetched(_that.username);case _SortChanged():
return sortChanged(_that.sortType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String username)?  fetched,TResult? Function( RepoSortType sortType)?  sortChanged,}) {final _that = this;
switch (_that) {
case _Fetched() when fetched != null:
return fetched(_that.username);case _SortChanged() when sortChanged != null:
return sortChanged(_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _Fetched implements RepoEvent {
  const _Fetched(this.username);
  

 final  String username;

/// Create a copy of RepoEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchedCopyWith<_Fetched> get copyWith => __$FetchedCopyWithImpl<_Fetched>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Fetched&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'RepoEvent.fetched(username: $username)';
}


}

/// @nodoc
abstract mixin class _$FetchedCopyWith<$Res> implements $RepoEventCopyWith<$Res> {
  factory _$FetchedCopyWith(_Fetched value, $Res Function(_Fetched) _then) = __$FetchedCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class __$FetchedCopyWithImpl<$Res>
    implements _$FetchedCopyWith<$Res> {
  __$FetchedCopyWithImpl(this._self, this._then);

  final _Fetched _self;
  final $Res Function(_Fetched) _then;

/// Create a copy of RepoEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_Fetched(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SortChanged implements RepoEvent {
  const _SortChanged(this.sortType);
  

 final  RepoSortType sortType;

/// Create a copy of RepoEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SortChangedCopyWith<_SortChanged> get copyWith => __$SortChangedCopyWithImpl<_SortChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SortChanged&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,sortType);

@override
String toString() {
  return 'RepoEvent.sortChanged(sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$SortChangedCopyWith<$Res> implements $RepoEventCopyWith<$Res> {
  factory _$SortChangedCopyWith(_SortChanged value, $Res Function(_SortChanged) _then) = __$SortChangedCopyWithImpl;
@useResult
$Res call({
 RepoSortType sortType
});




}
/// @nodoc
class __$SortChangedCopyWithImpl<$Res>
    implements _$SortChangedCopyWith<$Res> {
  __$SortChangedCopyWithImpl(this._self, this._then);

  final _SortChanged _self;
  final $Res Function(_SortChanged) _then;

/// Create a copy of RepoEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sortType = null,}) {
  return _then(_SortChanged(
null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as RepoSortType,
  ));
}


}

/// @nodoc
mixin _$RepoState {

 bool get isLoading; bool get isError; String get errorMessage; List<GithubRepoModel> get repos; RepoSortType get sortType;
/// Create a copy of RepoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepoStateCopyWith<RepoState> get copyWith => _$RepoStateCopyWithImpl<RepoState>(this as RepoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.repos, repos)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isError,errorMessage,const DeepCollectionEquality().hash(repos),sortType);

@override
String toString() {
  return 'RepoState(isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, repos: $repos, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class $RepoStateCopyWith<$Res>  {
  factory $RepoStateCopyWith(RepoState value, $Res Function(RepoState) _then) = _$RepoStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isError, String errorMessage, List<GithubRepoModel> repos, RepoSortType sortType
});




}
/// @nodoc
class _$RepoStateCopyWithImpl<$Res>
    implements $RepoStateCopyWith<$Res> {
  _$RepoStateCopyWithImpl(this._self, this._then);

  final RepoState _self;
  final $Res Function(RepoState) _then;

/// Create a copy of RepoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isError = null,Object? errorMessage = null,Object? repos = null,Object? sortType = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,repos: null == repos ? _self.repos : repos // ignore: cast_nullable_to_non_nullable
as List<GithubRepoModel>,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as RepoSortType,
  ));
}

}


/// Adds pattern-matching-related methods to [RepoState].
extension RepoStatePatterns on RepoState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepoState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepoState value)  $default,){
final _that = this;
switch (_that) {
case _RepoState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepoState value)?  $default,){
final _that = this;
switch (_that) {
case _RepoState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isError,  String errorMessage,  List<GithubRepoModel> repos,  RepoSortType sortType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepoState() when $default != null:
return $default(_that.isLoading,_that.isError,_that.errorMessage,_that.repos,_that.sortType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isError,  String errorMessage,  List<GithubRepoModel> repos,  RepoSortType sortType)  $default,) {final _that = this;
switch (_that) {
case _RepoState():
return $default(_that.isLoading,_that.isError,_that.errorMessage,_that.repos,_that.sortType);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isError,  String errorMessage,  List<GithubRepoModel> repos,  RepoSortType sortType)?  $default,) {final _that = this;
switch (_that) {
case _RepoState() when $default != null:
return $default(_that.isLoading,_that.isError,_that.errorMessage,_that.repos,_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _RepoState implements RepoState {
   _RepoState({required this.isLoading, required this.isError, required this.errorMessage, required final  List<GithubRepoModel> repos, required this.sortType}): _repos = repos;
  

@override final  bool isLoading;
@override final  bool isError;
@override final  String errorMessage;
 final  List<GithubRepoModel> _repos;
@override List<GithubRepoModel> get repos {
  if (_repos is EqualUnmodifiableListView) return _repos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_repos);
}

@override final  RepoSortType sortType;

/// Create a copy of RepoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepoStateCopyWith<_RepoState> get copyWith => __$RepoStateCopyWithImpl<_RepoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._repos, _repos)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isError,errorMessage,const DeepCollectionEquality().hash(_repos),sortType);

@override
String toString() {
  return 'RepoState(isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, repos: $repos, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$RepoStateCopyWith<$Res> implements $RepoStateCopyWith<$Res> {
  factory _$RepoStateCopyWith(_RepoState value, $Res Function(_RepoState) _then) = __$RepoStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isError, String errorMessage, List<GithubRepoModel> repos, RepoSortType sortType
});




}
/// @nodoc
class __$RepoStateCopyWithImpl<$Res>
    implements _$RepoStateCopyWith<$Res> {
  __$RepoStateCopyWithImpl(this._self, this._then);

  final _RepoState _self;
  final $Res Function(_RepoState) _then;

/// Create a copy of RepoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isError = null,Object? errorMessage = null,Object? repos = null,Object? sortType = null,}) {
  return _then(_RepoState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,repos: null == repos ? _self._repos : repos // ignore: cast_nullable_to_non_nullable
as List<GithubRepoModel>,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as RepoSortType,
  ));
}


}

// dart format on
