import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

const String _rememberedUserIdKey = 'remembered_user_id';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthRepository _authRepository;
  final SharedPreferences _prefs;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required AuthRepository authRepository,
    required SharedPreferences prefs,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _authRepository = authRepository,
        _prefs = prefs,
        super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        login: (email, password, rememberMe) =>
            _onLogin(email, password, rememberMe, emit),
        register: (email, password, userName, storeName) =>
            _onRegister(email, password, userName, storeName, emit),
        checkRememberedUser: () => _onCheckRememberedUser(emit),
        logout: () => _onLogout(emit),
      );
    });
  }

  Future<void> _onLogin(
    String email,
    String password,
    bool rememberMe,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _loginUseCase(email, password);

    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) {
        if (rememberMe) {
          _prefs.setInt(_rememberedUserIdKey, user.id);
        } else {
          _prefs.remove(_rememberedUserIdKey);
        }
        emit(AuthState.authenticated(user));
      },
    );
  }

  Future<void> _onRegister(
    String email,
    String password,
    String userName,
    String storeName,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _registerUseCase(
      email: email,
      password: password,
      userName: userName,
      storeName: storeName,
    );

    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) {
        // Auto-remember after registration
        _prefs.setInt(_rememberedUserIdKey, user.id);
        emit(AuthState.authenticated(user));
      },
    );
  }

  Future<void> _onCheckRememberedUser(Emitter<AuthState> emit) async {
    final userId = _prefs.getInt(_rememberedUserIdKey);

    if (userId == null) {
      emit(const AuthState.unauthenticated());
      return;
    }

    emit(const AuthState.loading());

    final result = await _authRepository.getUserById(userId);

    result.fold(
      (failure) {
        _prefs.remove(_rememberedUserIdKey);
        emit(const AuthState.unauthenticated());
      },
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onLogout(Emitter<AuthState> emit) async {
    _prefs.remove(_rememberedUserIdKey);
    emit(const AuthState.unauthenticated());
  }
}
