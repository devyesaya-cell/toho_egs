import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/person.dart';

enum SystemMode { spot, crumbling, maintenance }

class AuthState {
  final Person? currentUser;
  final SystemMode mode;

  AuthState({
    this.currentUser,
    this.mode = SystemMode.spot, // Default to Spot
  });

  AuthState copyWith({Person? currentUser, SystemMode? mode}) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      mode: mode ?? this.mode,
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
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
