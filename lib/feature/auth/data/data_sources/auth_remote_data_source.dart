import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<void> register({required String password, required String email});

  Future<void> login({required String password, required String email});

  Future<void> logout();

  Session? get getCurrentSession;
 }
