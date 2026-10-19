// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'received_reports.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReceivedReportsState {

 List<ReceivedReport> get items; int get total; int get page; bool get loadingMore;
/// Create a copy of ReceivedReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceivedReportsStateCopyWith<ReceivedReportsState> get copyWith => _$ReceivedReportsStateCopyWithImpl<ReceivedReportsState>(this as ReceivedReportsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceivedReportsState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,page,loadingMore);

@override
String toString() {
  return 'ReceivedReportsState(items: $items, total: $total, page: $page, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class $ReceivedReportsStateCopyWith<$Res>  {
  factory $ReceivedReportsStateCopyWith(ReceivedReportsState value, $Res Function(ReceivedReportsState) _then) = _$ReceivedReportsStateCopyWithImpl;
@useResult
$Res call({
 List<ReceivedReport> items, int total, int page, bool loadingMore
});




}
/// @nodoc
class _$ReceivedReportsStateCopyWithImpl<$Res>
    implements $ReceivedReportsStateCopyWith<$Res> {
  _$ReceivedReportsStateCopyWithImpl(this._self, this._then);

  final ReceivedReportsState _self;
  final $Res Function(ReceivedReportsState) _then;

/// Create a copy of ReceivedReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? page = null,Object? loadingMore = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReceivedReport>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceivedReportsState].
extension ReceivedReportsStatePatterns on ReceivedReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceivedReportsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceivedReportsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceivedReportsState value)  $default,){
final _that = this;
switch (_that) {
case _ReceivedReportsState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceivedReportsState value)?  $default,){
final _that = this;
switch (_that) {
case _ReceivedReportsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReceivedReport> items,  int total,  int page,  bool loadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceivedReportsState() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.loadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReceivedReport> items,  int total,  int page,  bool loadingMore)  $default,) {final _that = this;
switch (_that) {
case _ReceivedReportsState():
return $default(_that.items,_that.total,_that.page,_that.loadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReceivedReport> items,  int total,  int page,  bool loadingMore)?  $default,) {final _that = this;
switch (_that) {
case _ReceivedReportsState() when $default != null:
return $default(_that.items,_that.total,_that.page,_that.loadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _ReceivedReportsState extends ReceivedReportsState {
  const _ReceivedReportsState({required final  List<ReceivedReport> items, required this.total, this.page = 1, this.loadingMore = false}): _items = items,super._();
  

 final  List<ReceivedReport> _items;
@override List<ReceivedReport> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int total;
@override@JsonKey() final  int page;
@override@JsonKey() final  bool loadingMore;

/// Create a copy of ReceivedReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceivedReportsStateCopyWith<_ReceivedReportsState> get copyWith => __$ReceivedReportsStateCopyWithImpl<_ReceivedReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceivedReportsState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,page,loadingMore);

@override
String toString() {
  return 'ReceivedReportsState(items: $items, total: $total, page: $page, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class _$ReceivedReportsStateCopyWith<$Res> implements $ReceivedReportsStateCopyWith<$Res> {
  factory _$ReceivedReportsStateCopyWith(_ReceivedReportsState value, $Res Function(_ReceivedReportsState) _then) = __$ReceivedReportsStateCopyWithImpl;
@override @useResult
$Res call({
 List<ReceivedReport> items, int total, int page, bool loadingMore
});




}
/// @nodoc
class __$ReceivedReportsStateCopyWithImpl<$Res>
    implements _$ReceivedReportsStateCopyWith<$Res> {
  __$ReceivedReportsStateCopyWithImpl(this._self, this._then);

  final _ReceivedReportsState _self;
  final $Res Function(_ReceivedReportsState) _then;

/// Create a copy of ReceivedReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? page = null,Object? loadingMore = null,}) {
  return _then(_ReceivedReportsState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReceivedReport>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
