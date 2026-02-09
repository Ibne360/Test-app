import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../core/enums.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabase;

  AuthRepositoryImpl(this._supabase);

  @override
  Stream<UserEntity?> get authStateChanges =>
      _supabase.auth.onAuthStateChange.asyncMap((event) async {
        final session = event.session;
        if (session == null) return null;
        return await getCurrentUser(); // Fetch profile on auth change
      });

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (data == null) {
        // Profile might not exist yet if just registered?
        return UserModel(
          id: user.id,
          email: user.email ?? '',
          role: UserRole.customer,
        );
      }
      // Merge auth email with profile data
      final Map<String, dynamic> profileData = Map<String, dynamic>.from(data);
      profileData['email'] = user.email;

      return UserModel.fromJson(profileData);
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return null;
    }
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    await _supabase.auth.signUp(email: email, password: password);
    // Profile creation usually handled by Supabase Trigger, or we can do it here manually if needed.
    // Assuming Trigger for now or "lazy creation" on first profile fetch.
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<String?> getUserRole(String userId) async {
    final data = await _supabase
        .from('profiles')
        .select('role')
        .eq('id', userId)
        .maybeSingle();
    return data?['role'] as String?;
  }
}
