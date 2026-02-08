import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService(this._client);

  final SupabaseClient _client;

  SupabaseClient get client => _client;
  GoTrueClient get auth => _client.auth;
  SupabaseQueryBuilder from(String table) => _client.from(table);
  SupabaseStorageClient get storage => _client.storage;
}
