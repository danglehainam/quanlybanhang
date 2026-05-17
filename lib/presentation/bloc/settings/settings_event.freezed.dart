// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSettings value)?  loadSettings,TResult Function( ToggleLayoutView value)?  toggleLayoutView,TResult Function( ChangeLanguage value)?  changeLanguage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that);case ToggleLayoutView() when toggleLayoutView != null:
return toggleLayoutView(_that);case ChangeLanguage() when changeLanguage != null:
return changeLanguage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSettings value)  loadSettings,required TResult Function( ToggleLayoutView value)  toggleLayoutView,required TResult Function( ChangeLanguage value)  changeLanguage,}){
final _that = this;
switch (_that) {
case LoadSettings():
return loadSettings(_that);case ToggleLayoutView():
return toggleLayoutView(_that);case ChangeLanguage():
return changeLanguage(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSettings value)?  loadSettings,TResult? Function( ToggleLayoutView value)?  toggleLayoutView,TResult? Function( ChangeLanguage value)?  changeLanguage,}){
final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that);case ToggleLayoutView() when toggleLayoutView != null:
return toggleLayoutView(_that);case ChangeLanguage() when changeLanguage != null:
return changeLanguage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double screenWidth)?  loadSettings,TResult Function()?  toggleLayoutView,TResult Function( String languageCode)?  changeLanguage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that.screenWidth);case ToggleLayoutView() when toggleLayoutView != null:
return toggleLayoutView();case ChangeLanguage() when changeLanguage != null:
return changeLanguage(_that.languageCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double screenWidth)  loadSettings,required TResult Function()  toggleLayoutView,required TResult Function( String languageCode)  changeLanguage,}) {final _that = this;
switch (_that) {
case LoadSettings():
return loadSettings(_that.screenWidth);case ToggleLayoutView():
return toggleLayoutView();case ChangeLanguage():
return changeLanguage(_that.languageCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double screenWidth)?  loadSettings,TResult? Function()?  toggleLayoutView,TResult? Function( String languageCode)?  changeLanguage,}) {final _that = this;
switch (_that) {
case LoadSettings() when loadSettings != null:
return loadSettings(_that.screenWidth);case ToggleLayoutView() when toggleLayoutView != null:
return toggleLayoutView();case ChangeLanguage() when changeLanguage != null:
return changeLanguage(_that.languageCode);case _:
  return null;

}
}

}

/// @nodoc


class LoadSettings implements SettingsEvent {
  const LoadSettings(this.screenWidth);
  

 final  double screenWidth;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadSettingsCopyWith<LoadSettings> get copyWith => _$LoadSettingsCopyWithImpl<LoadSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSettings&&(identical(other.screenWidth, screenWidth) || other.screenWidth == screenWidth));
}


@override
int get hashCode => Object.hash(runtimeType,screenWidth);

@override
String toString() {
  return 'SettingsEvent.loadSettings(screenWidth: $screenWidth)';
}


}

/// @nodoc
abstract mixin class $LoadSettingsCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $LoadSettingsCopyWith(LoadSettings value, $Res Function(LoadSettings) _then) = _$LoadSettingsCopyWithImpl;
@useResult
$Res call({
 double screenWidth
});




}
/// @nodoc
class _$LoadSettingsCopyWithImpl<$Res>
    implements $LoadSettingsCopyWith<$Res> {
  _$LoadSettingsCopyWithImpl(this._self, this._then);

  final LoadSettings _self;
  final $Res Function(LoadSettings) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? screenWidth = null,}) {
  return _then(LoadSettings(
null == screenWidth ? _self.screenWidth : screenWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class ToggleLayoutView implements SettingsEvent {
  const ToggleLayoutView();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleLayoutView);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.toggleLayoutView()';
}


}




/// @nodoc


class ChangeLanguage implements SettingsEvent {
  const ChangeLanguage(this.languageCode);
  

 final  String languageCode;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeLanguageCopyWith<ChangeLanguage> get copyWith => _$ChangeLanguageCopyWithImpl<ChangeLanguage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeLanguage&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode);

@override
String toString() {
  return 'SettingsEvent.changeLanguage(languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $ChangeLanguageCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $ChangeLanguageCopyWith(ChangeLanguage value, $Res Function(ChangeLanguage) _then) = _$ChangeLanguageCopyWithImpl;
@useResult
$Res call({
 String languageCode
});




}
/// @nodoc
class _$ChangeLanguageCopyWithImpl<$Res>
    implements $ChangeLanguageCopyWith<$Res> {
  _$ChangeLanguageCopyWithImpl(this._self, this._then);

  final ChangeLanguage _self;
  final $Res Function(ChangeLanguage) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? languageCode = null,}) {
  return _then(ChangeLanguage(
null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
