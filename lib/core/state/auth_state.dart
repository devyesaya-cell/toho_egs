import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/person.dart';
import '../models/workfile.dart';

enum SystemMode { spot, crumbling, maintenance }

class AuthState {
  final Person? currentUser;
  final SystemMode mode;
  final WorkFile? activeWorkfile;

  AuthState({
    this.currentUser,
    this.mode = SystemMode.spot, // Default to Spot
    this.activeWorkfile,
  });

  AuthState copyWith({
    Person? currentUser,
    SystemMode? mode,
    WorkFile? activeWorkfile,
  }) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      mode: mode ?? this.mode,
      activeWorkfile: activeWorkfile ?? this.activeWorkfile,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  void login(Person user, SystemMode mode) {
    state = state.copyWith(currentUser: user, mode: mode);
  }

  void logout() {
    state = AuthState(); // Reset
  }

  void setMode(SystemMode mode) {
    state = state.copyWith(mode: mode);
  }

  void setActiveWorkfile(WorkFile workfile) {
    state = state.copyWith(activeWorkfile: workfile);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
