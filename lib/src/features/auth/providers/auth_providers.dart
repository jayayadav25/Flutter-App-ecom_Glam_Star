import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import '../data/auth_repository.dart';

// FirebaseAuth instance
final firebaseAuthProvider = Provider<fb.FirebaseAuth>((ref) {
  return fb.FirebaseAuth.instance;
});

// Google Sign-In instance
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    scopes: ['email'],
    serverClientId: "831856509099-9udfppvnfu0jhon2eqdrg8r9crutbqu4.apps.googleusercontent.com",
  );
});

// AuthRepository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    googleSignIn: ref.read(googleSignInProvider),
  );
});

// Firebase auth state listener
final authStateChangesProvider = StreamProvider<fb.User?>((ref) {
  return ref.read(firebaseAuthProvider).authStateChanges();
});

// Prevent redirect during login/signup/google
final authInProgressProvider = StateProvider<bool>((ref) => false);
