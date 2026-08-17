// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aquabook/src/core/modules/firebase_module.dart' as _i211;
import 'package:aquabook/src/core/modules/shared_preferences_module.dart'
    as _i144;
import 'package:aquabook/src/data/data_sources/authentication_data_source.dart'
    as _i137;
import 'package:aquabook/src/data/data_sources/firebase_storage_data_source.dart'
    as _i83;
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart'
    as _i151;
import 'package:aquabook/src/data/data_sources/image_picker_data_source.dart'
    as _i1069;
import 'package:aquabook/src/data/repositories/authentication_repository.dart'
    as _i472;
import 'package:aquabook/src/data/repositories/booking_repository.dart'
    as _i961;
import 'package:aquabook/src/data/repositories/business_repository.dart'
    as _i1065;
import 'package:aquabook/src/data/repositories/onboarding_repository.dart'
    as _i366;
import 'package:aquabook/src/data/repositories/user_repository.dart' as _i747;
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_bloc.dart'
    as _i458;
import 'package:aquabook/src/features/business-side/bookings/bloc/client_bookings_cubit.dart'
    as _i488;
import 'package:aquabook/src/features/business-side/dashboard/bloc/dashboard_cubit.dart'
    as _i758;
import 'package:aquabook/src/features/business-side/home/bloc/client_entry_cubit.dart'
    as _i1018;
import 'package:aquabook/src/features/business-side/home/bloc/home_bloc.dart'
    as _i952;
import 'package:aquabook/src/features/business-side/my_businesses/bloc/my_businesses_cubit.dart'
    as _i908;
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_cubit.dart'
    as _i567;
import 'package:aquabook/src/features/customer-side/payment/cubit/payment_cubit.dart'
    as _i415;
import 'package:aquabook/src/features/customer-side/profile/cubit/customer_profile_cubit.dart'
    as _i897;
import 'package:aquabook/src/features/customer-side/review_stay/cubit/review_stay_cubit.dart'
    as _i192;
import 'package:aquabook/src/features/customer-side/search/cubit/customer_search_cubit.dart'
    as _i940;
import 'package:aquabook/src/features/customer-side/stay_detail/cubit/stay_detail_cubit.dart'
    as _i386;
import 'package:aquabook/src/features/shared/onboarding/cubit/onboarding_cubit.dart'
    as _i680;
import 'package:aquabook/src/features/shared/sign_in/cubit/signin_cubit.dart'
    as _i44;
import 'package:aquabook/src/features/shared/sign_up/cubit/signup_cubit.dart'
    as _i1028;
import 'package:aquabook/src/features/shared/user_type_checker/cubit/user_type_checker_cubit.dart'
    as _i30;
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
    gh.lazySingleton<_i1069.ImagePickerDataSource>(
      () => _i1069.ImagePickerDataSourceImpl(),
    );
    gh.lazySingleton<_i366.OnboardingRepository>(
      () => _i366.OnboardingRepository(gh<_i460.SharedPreferences>()),
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
    gh.factory<_i680.OnboardingCubit>(
      () => _i680.OnboardingCubit(gh<_i366.OnboardingRepository>()),
    );
    gh.lazySingleton<_i151.FirestoreDataSource>(
      () => _i151.FirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i83.FirebaseStorageDataSource>(
      () => _i83.FirebaseStorageDataSourceImpl(gh<_i457.FirebaseStorage>()),
    );
    gh.lazySingleton<_i137.AuthenticationDataSource>(
      () => _i137.AuthenticationDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i747.UserRepository>(
      () => _i747.UserRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i472.AuthenticationRepository>(
      () => _i472.AuthenticationRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i1065.BusinessRepository>(
      () => _i1065.BusinessRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i83.FirebaseStorageDataSource>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i1028.SignupCubit>(
      () => _i1028.SignupCubit(gh<_i472.AuthenticationRepository>()),
    );
    gh.factory<_i952.HomeBloc>(
      () => _i952.HomeBloc(gh<_i472.AuthenticationRepository>()),
    );
    gh.factory<_i897.CustomerProfileCubit>(
      () => _i897.CustomerProfileCubit(gh<_i472.AuthenticationRepository>()),
    );
    gh.factory<_i758.DashboardCubit>(
      () => _i758.DashboardCubit(
        gh<_i747.UserRepository>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.factory<_i567.CustomerDashboardCubit>(
      () => _i567.CustomerDashboardCubit(gh<_i1065.BusinessRepository>()),
    );
    gh.factory<_i940.CustomerSearchCubit>(
      () => _i940.CustomerSearchCubit(gh<_i1065.BusinessRepository>()),
    );
    gh.factory<_i386.StayDetailCubit>(
      () => _i386.StayDetailCubit(gh<_i1065.BusinessRepository>()),
    );
    gh.factory<_i192.ReviewStayCubit>(
      () => _i192.ReviewStayCubit(gh<_i1065.BusinessRepository>()),
    );
    gh.factory<_i30.UserTypeCheckerCubit>(
      () => _i30.UserTypeCheckerCubit(gh<_i747.UserRepository>()),
    );
    gh.factory<_i1018.ClientEntryCubit>(
      () => _i1018.ClientEntryCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i908.MyBusinessesCubit>(
      () => _i908.MyBusinessesCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i44.SigninCubit>(
      () => _i44.SigninCubit(
        gh<_i472.AuthenticationRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.lazySingleton<_i961.BookingRepository>(
      () => _i961.BookingRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.factory<_i458.AddBusinessBloc>(
      () => _i458.AddBusinessBloc(
        gh<_i1069.ImagePickerDataSource>(),
        gh<_i460.SharedPreferences>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.factory<_i415.PaymentCubit>(
      () => _i415.PaymentCubit(gh<_i961.BookingRepository>()),
    );
    gh.factory<_i488.ClientBookingsCubit>(
      () => _i488.ClientBookingsCubit(
        gh<_i961.BookingRepository>(),
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i211.FirebaseModule {}

class _$SharedPrefsModule extends _i144.SharedPrefsModule {}
