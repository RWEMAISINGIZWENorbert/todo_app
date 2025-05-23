import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
   
   ThemeCubit(): super(ThemeMode.light);

   void updateTheme(ThemeMode theme) => emit(theme);
    
  @override
   ThemeMode? fromJson(Map<String, dynamic> json) {
      return ThemeMode.values[json['theme'] as int];
  }

  @override
  Map<String, dynamic>? toJson(state) {
      return {'theme': state.index};
  }
} 