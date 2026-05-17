import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_layout_preference_usecase.dart';
import '../../../domain/usecases/save_layout_preference_usecase.dart';
import '../../../domain/usecases/get_language_usecase.dart';
import '../../../domain/usecases/save_language_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetLayoutPreferenceUseCase _getLayoutPreferenceUseCase;
  final SaveLayoutPreferenceUseCase _saveLayoutPreferenceUseCase;
  final GetLanguageUseCase _getLanguageUseCase;
  final SaveLanguageUseCase _saveLanguageUseCase;

  SettingsBloc({
    required GetLayoutPreferenceUseCase getLayoutPreferenceUseCase,
    required SaveLayoutPreferenceUseCase saveLayoutPreferenceUseCase,
    required GetLanguageUseCase getLanguageUseCase,
    required SaveLanguageUseCase saveLanguageUseCase,
  })  : _getLayoutPreferenceUseCase = getLayoutPreferenceUseCase,
        _saveLayoutPreferenceUseCase = saveLayoutPreferenceUseCase,
        _getLanguageUseCase = getLanguageUseCase,
        _saveLanguageUseCase = saveLanguageUseCase,
        super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleLayoutView>(_onToggleLayoutView);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final savedPreference = _getLayoutPreferenceUseCase();
    final savedLanguage = _getLanguageUseCase();
    
    bool isMobileView;
    if (savedPreference != null) {
      isMobileView = savedPreference;
    } else {
      isMobileView = event.screenWidth < 800;
    }

    emit(state.copyWith(
      isMobileView: isMobileView,
      languageCode: savedLanguage ?? 'vi',
    ));
  }

  Future<void> _onToggleLayoutView(ToggleLayoutView event, Emitter<SettingsState> emit) async {
    final newValue = !state.isMobileView;
    emit(state.copyWith(isMobileView: newValue));
    await _saveLayoutPreferenceUseCase(newValue);
  }

  Future<void> _onChangeLanguage(ChangeLanguage event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(languageCode: event.languageCode));
    await _saveLanguageUseCase(event.languageCode);
  }
}
