import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/login_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/plan_trip_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/my_profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_viewmodel.dart';


GetIt locator = GetIt.instance;

Future<void> setUpLocator() async{
  //services
  locator.registerSingleton<FirebaseService>(FirebaseService());

  //viewmodel
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<PlanTripViewModel>(() => PlanTripViewModel());
  locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  locator.registerFactory<MyProfileViewModel>(() => MyProfileViewModel());
  locator.registerFactory<RewardsViewModel>(() => RewardsViewModel());

}