import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/change_password_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/code_verification_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/driver_verification_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/custom_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/forgot_password_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/carpool_details_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/my_rewards_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/new_password_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/redemption_history_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_card_details_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/homepage_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/trip_passenger_request_view_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/activity_page_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/create_custom_trip_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/login_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/map_navigation_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/ongoing_trip_details_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/plan_trip_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/my_profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/navigation_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app_development_cw2/viewmodels/request_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/search_available_trips_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/trip_details_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/edit_profile_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/activity_page_viewmodel.dart';


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
  locator.registerFactory<EditProfileViewModel>(() => EditProfileViewModel());
  locator.registerFactory<NavigationViewModel>(() => NavigationViewModel());
  locator.registerFactory<MapNavigationViewModel>(() => MapNavigationViewModel());
  locator.registerFactory<SearchAvailableTripsViewModel>(() => SearchAvailableTripsViewModel());
  locator.registerFactory<RequestCarpoolViewmodel>(() => RequestCarpoolViewmodel());
  locator.registerFactory<CreateCustomTripViewmodel>(() => CreateCustomTripViewmodel());
  locator.registerFactory<TripPassengerRequestViewModel>(() => TripPassengerRequestViewModel());
  locator.registerFactory<HomepageViewModel>(() => HomepageViewModel());
  locator.registerFactory<RewardsCardDetailsViewModel>(() => RewardsCardDetailsViewModel());
  locator.registerFactory<MyRewardsViewModel>(() => MyRewardsViewModel());
  locator.registerFactory<CarpoolDetailsViewModel>(() => CarpoolDetailsViewModel());
  locator.registerFactory<RedemptionHistoryViewModel>(() => RedemptionHistoryViewModel());
  locator.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  locator.registerFactory<ChangePasswordViewModel>(() => ChangePasswordViewModel());
  locator.registerFactory<NewPasswordViewModel>(() => NewPasswordViewModel());
  locator.registerFactory<CodeVerificationViewModel>(() => CodeVerificationViewModel());
  locator.registerFactory<DriverVerificationViewModel>(() => DriverVerificationViewModel());
  locator.registerFactory<CustomCarpoolViewmodel>(() => CustomCarpoolViewmodel());
}


