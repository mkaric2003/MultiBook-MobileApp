// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aquabook/src/core/modules/firebase_module.dart' as _i211;
import 'package:aquabook/src/core/modules/shared_preferences_module.dart'
    as _i144;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final sharedPrefsModule = _$SharedPrefsModule();
    await gh.singletonAsync<_i982.FirebaseApp>(
      () => firebaseModule.firebaseApp,
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i59.FirebaseAuth>(
      () => firebaseModule.firebaseAuth(gh<_i982.FirebaseApp>()),
    );
    gh.singleton<_i457.FirebaseStorage>(
      () => firebaseModule.firebaseStorage(gh<_i982.FirebaseApp>()),
    );
    gh.singleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore(gh<_i982.FirebaseApp>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i211.FirebaseModule {}

class _$SharedPrefsModule extends _i144.SharedPrefsModule {}
