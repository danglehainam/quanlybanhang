// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsEvent()';
}


}

/// @nodoc
class $ProductsEventCopyWith<$Res>  {
$ProductsEventCopyWith(ProductsEvent _, $Res Function(ProductsEvent) __);
}


/// Adds pattern-matching-related methods to [ProductsEvent].
extension ProductsEventPatterns on ProductsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WatchProducts value)?  watchProducts,TResult Function( CreateProduct value)?  createProduct,TResult Function( UpdateProduct value)?  updateProduct,TResult Function( DeleteProduct value)?  deleteProduct,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WatchProducts() when watchProducts != null:
return watchProducts(_that);case CreateProduct() when createProduct != null:
return createProduct(_that);case UpdateProduct() when updateProduct != null:
return updateProduct(_that);case DeleteProduct() when deleteProduct != null:
return deleteProduct(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WatchProducts value)  watchProducts,required TResult Function( CreateProduct value)  createProduct,required TResult Function( UpdateProduct value)  updateProduct,required TResult Function( DeleteProduct value)  deleteProduct,}){
final _that = this;
switch (_that) {
case WatchProducts():
return watchProducts(_that);case CreateProduct():
return createProduct(_that);case UpdateProduct():
return updateProduct(_that);case DeleteProduct():
return deleteProduct(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WatchProducts value)?  watchProducts,TResult? Function( CreateProduct value)?  createProduct,TResult? Function( UpdateProduct value)?  updateProduct,TResult? Function( DeleteProduct value)?  deleteProduct,}){
final _that = this;
switch (_that) {
case WatchProducts() when watchProducts != null:
return watchProducts(_that);case CreateProduct() when createProduct != null:
return createProduct(_that);case UpdateProduct() when updateProduct != null:
return updateProduct(_that);case DeleteProduct() when deleteProduct != null:
return deleteProduct(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  watchProducts,TResult Function( ProductEntity product,  void Function() onSuccess,  void Function(String) onError)?  createProduct,TResult Function( ProductEntity product,  void Function() onSuccess,  void Function(String) onError)?  updateProduct,TResult Function( int id,  void Function() onSuccess,  void Function(String) onError)?  deleteProduct,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WatchProducts() when watchProducts != null:
return watchProducts();case CreateProduct() when createProduct != null:
return createProduct(_that.product,_that.onSuccess,_that.onError);case UpdateProduct() when updateProduct != null:
return updateProduct(_that.product,_that.onSuccess,_that.onError);case DeleteProduct() when deleteProduct != null:
return deleteProduct(_that.id,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  watchProducts,required TResult Function( ProductEntity product,  void Function() onSuccess,  void Function(String) onError)  createProduct,required TResult Function( ProductEntity product,  void Function() onSuccess,  void Function(String) onError)  updateProduct,required TResult Function( int id,  void Function() onSuccess,  void Function(String) onError)  deleteProduct,}) {final _that = this;
switch (_that) {
case WatchProducts():
return watchProducts();case CreateProduct():
return createProduct(_that.product,_that.onSuccess,_that.onError);case UpdateProduct():
return updateProduct(_that.product,_that.onSuccess,_that.onError);case DeleteProduct():
return deleteProduct(_that.id,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  watchProducts,TResult? Function( ProductEntity product,  void Function() onSuccess,  void Function(String) onError)?  createProduct,TResult? Function( ProductEntity product,  void Function() onSuccess,  void Function(String) onError)?  updateProduct,TResult? Function( int id,  void Function() onSuccess,  void Function(String) onError)?  deleteProduct,}) {final _that = this;
switch (_that) {
case WatchProducts() when watchProducts != null:
return watchProducts();case CreateProduct() when createProduct != null:
return createProduct(_that.product,_that.onSuccess,_that.onError);case UpdateProduct() when updateProduct != null:
return updateProduct(_that.product,_that.onSuccess,_that.onError);case DeleteProduct() when deleteProduct != null:
return deleteProduct(_that.id,_that.onSuccess,_that.onError);case _:
  return null;

}
}

}

/// @nodoc


class WatchProducts implements ProductsEvent {
  const WatchProducts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchProducts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsEvent.watchProducts()';
}


}




/// @nodoc


class CreateProduct implements ProductsEvent {
  const CreateProduct(this.product, {required this.onSuccess, required this.onError});
  

 final  ProductEntity product;
 final  void Function() onSuccess;
 final  void Function(String) onError;

/// Create a copy of ProductsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateProductCopyWith<CreateProduct> get copyWith => _$CreateProductCopyWithImpl<CreateProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateProduct&&(identical(other.product, product) || other.product == product)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,product,onSuccess,onError);

@override
String toString() {
  return 'ProductsEvent.createProduct(product: $product, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $CreateProductCopyWith<$Res> implements $ProductsEventCopyWith<$Res> {
  factory $CreateProductCopyWith(CreateProduct value, $Res Function(CreateProduct) _then) = _$CreateProductCopyWithImpl;
@useResult
$Res call({
 ProductEntity product, void Function() onSuccess, void Function(String) onError
});




}
/// @nodoc
class _$CreateProductCopyWithImpl<$Res>
    implements $CreateProductCopyWith<$Res> {
  _$CreateProductCopyWithImpl(this._self, this._then);

  final CreateProduct _self;
  final $Res Function(CreateProduct) _then;

/// Create a copy of ProductsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(CreateProduct(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductEntity,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String),
  ));
}


}

/// @nodoc


class UpdateProduct implements ProductsEvent {
  const UpdateProduct(this.product, {required this.onSuccess, required this.onError});
  

 final  ProductEntity product;
 final  void Function() onSuccess;
 final  void Function(String) onError;

/// Create a copy of ProductsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProductCopyWith<UpdateProduct> get copyWith => _$UpdateProductCopyWithImpl<UpdateProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProduct&&(identical(other.product, product) || other.product == product)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,product,onSuccess,onError);

@override
String toString() {
  return 'ProductsEvent.updateProduct(product: $product, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $UpdateProductCopyWith<$Res> implements $ProductsEventCopyWith<$Res> {
  factory $UpdateProductCopyWith(UpdateProduct value, $Res Function(UpdateProduct) _then) = _$UpdateProductCopyWithImpl;
@useResult
$Res call({
 ProductEntity product, void Function() onSuccess, void Function(String) onError
});




}
/// @nodoc
class _$UpdateProductCopyWithImpl<$Res>
    implements $UpdateProductCopyWith<$Res> {
  _$UpdateProductCopyWithImpl(this._self, this._then);

  final UpdateProduct _self;
  final $Res Function(UpdateProduct) _then;

/// Create a copy of ProductsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(UpdateProduct(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductEntity,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String),
  ));
}


}

/// @nodoc


class DeleteProduct implements ProductsEvent {
  const DeleteProduct(this.id, {required this.onSuccess, required this.onError});
  

 final  int id;
 final  void Function() onSuccess;
 final  void Function(String) onError;

/// Create a copy of ProductsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteProductCopyWith<DeleteProduct> get copyWith => _$DeleteProductCopyWithImpl<DeleteProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,id,onSuccess,onError);

@override
String toString() {
  return 'ProductsEvent.deleteProduct(id: $id, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $DeleteProductCopyWith<$Res> implements $ProductsEventCopyWith<$Res> {
  factory $DeleteProductCopyWith(DeleteProduct value, $Res Function(DeleteProduct) _then) = _$DeleteProductCopyWithImpl;
@useResult
$Res call({
 int id, void Function() onSuccess, void Function(String) onError
});




}
/// @nodoc
class _$DeleteProductCopyWithImpl<$Res>
    implements $DeleteProductCopyWith<$Res> {
  _$DeleteProductCopyWithImpl(this._self, this._then);

  final DeleteProduct _self;
  final $Res Function(DeleteProduct) _then;

/// Create a copy of ProductsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(DeleteProduct(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String),
  ));
}


}

// dart format on
