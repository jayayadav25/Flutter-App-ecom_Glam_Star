import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../data/auth_repository.dart';
import 'auth_providers.dart';

// ======================================================
//               AUTH STATE MODEL
// ======================================================
class AuthState {
  final fb.User? user;
  final bool loading;
  final String? error;

  const AuthState({
    required this.user,
    required this.loading,
    required this.error,
  });

  factory AuthState.initial() =>
      const AuthState(user: null, loading: false, error: null);

  AuthState copyWith({
    fb.User? user,
    bool? loading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

// ======================================================
//                  AUTH CONTROLLER
// ======================================================
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _repo;
  final Ref ref;

  AuthController(this._repo, this.ref) : super(AuthState.initial());

  // EMAIL LOGIN
  Future<void> signIn(String email, String password) async {
    try {
      state = state.copyWith(loading: true, error: null);
      ref.read(authInProgressProvider.notifier).state = true;

      final user = await _repo.signIn(email, password);
      state = state.copyWith(user: user, loading: false);

    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    } finally {
      ref.read(authInProgressProvider.notifier).state = false;
    }
  }

  // EMAIL SIGNUP
  Future<void> signUp(String name, String email, String password) async {
    try {
      state = state.copyWith(loading: true, error: null);
      ref.read(authInProgressProvider.notifier).state = true;

      final user = await _repo.signUp(email, password, name);
      state = state.copyWith(user: user, loading: false);

    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    } finally {
      ref.read(authInProgressProvider.notifier).state = false;
    }
  }


  // GOOGLE AUTH
  Future<void> signInWithGoogle() async {
    try {
      state = state.copyWith(loading: true, error: null);
      ref.read(authInProgressProvider.notifier).state = true;

      final user = await _repo.signInWithGoogle();
      state = state.copyWith(user: user, loading: false);

    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    } finally {
      ref.read(authInProgressProvider.notifier).state = false;
    }
  }

  // LOGOUT
  Future<void> signOut() async {
    await _repo.signOut();
    state = AuthState.initial();
  }
}

// PROVIDER
final authControllerProvider =
StateNotifierProvider<AuthController, AuthState>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthController(repo, ref);
});
