// file lib/provider/user_provider.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';


class UserAuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

    UserAuthProvider() {
    // Initialize the current user
    final supabaseUser = _supabase.auth.currentUser;
    _currentUser = supabaseUser != null ? User.fromJson(supabaseUser.toJson()) : null;
    
    // Listen for auth state changes
    _supabase.auth.onAuthStateChange.listen((data) {
      final authUser = data.session?.user;
      _currentUser = authUser != null ? User.fromJson(authUser.toJson()) : null;
      notifyListeners();
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      print('Error signing up: $e');
    }
    notifyListeners();
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      _currentUser = response.user != null ? User.fromJson(response.user!.toJson()) : null;
      notifyListeners();
      print('User signed in: ${_currentUser?.id}');
      // Print session details for debugging
      print('Session: ${response.session?.toJson()}');
    } catch (e) {
      print('Error signing in: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      final response = await _supabase.auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}