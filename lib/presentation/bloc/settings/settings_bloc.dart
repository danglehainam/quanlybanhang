import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_layout_preference_usecase.dart';
import '../../../domain/usecases/save_layout_preference_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetLayoutPreferenceUseCase _getLayoutPreferenceUseCase;
  final SaveLayoutPreferenceUseCase _saveLayoutPreferenceUseCase;

  SettingsBloc({
    required GetLayoutPreferenceUseCase getLayoutPreferenceUseCase,
    required SaveLayoutPreferenceUseCase saveLayoutPreferenceUseCase,
  })  : _getLayoutPreferenceUseCase = getLayoutPreferenceUseCase,
        _saveLayoutPreferenceUseCase = saveLayoutPreferenceUseCase,
        super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleLayoutView>(_onToggleLayoutView);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final savedPreference = _getLayoutPreferenceUseCase.execute();
    
    if (savedPreference != null) {
      emit(state.copyWith(isMobileView: savedPreference));
    } else {
      // First time, detect from screen width
      final isMobile = event.screenWidth < 800;
      emit(state.copyWith(isMobileView: isMobile));
    }
  }

  Future<void> _onToggleLayoutView(ToggleLayoutView event, Emitter<SettingsState> emit) async {
    final newValue = !state.isMobileView;
    emit(state.copyWith(isMobileView: newValue));
    await _saveLayoutPreferenceUseCase.execute(newValue);
  }
}
