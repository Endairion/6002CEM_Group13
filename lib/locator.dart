import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/activity_page_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/login_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/map_navigation_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/ongoing_trip_details_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/plan_trip_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/my_profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app_development_cw2/viewmodels/request_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/search_available_trips_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/trip_details_viewmodel.dart';


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
  locator.registerFactory<ActivityPageViewModel>(() => ActivityPageViewModel());
  locator.registerFactory<TripDetailsViewModel>(() => TripDetailsViewModel());
  locator.registerFactory<RewardsViewModel>(() => RewardsViewModel());
  locator.registerFactory<OngoingTripDetailsViewModel>(() => OngoingTripDetailsViewModel());
  locator.registerFactory<MapNavigationViewModel>(() => MapNavigationViewModel());
  locator.registerFactory<SearchAvailableTripsViewmodel>(() => SearchAvailableTripsViewmodel());
  locator.registerFactory<RequestCarpoolViewmodel>(() => RequestCarpoolViewmodel());
}

