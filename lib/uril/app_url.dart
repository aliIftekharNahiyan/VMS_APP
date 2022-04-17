class AppUrl {
 // static const String liveBaseURL = "https://shiny-awful-wildebeast.gigalixirapp.com/api/v1";
  static const String localBaseURL = "https://vms.griho.app/api";

  static const String baseURL = localBaseURL;
  static const String login = baseURL + "/Login/Login";
  static const String register = baseURL + "/userregistration/RegisterUser?hash=wdc7mmlaopD";
 // static const String forgotPassword = baseURL + "/userregistration/ForgotPassword?msisdn=_phoneNumber&hash=1234";
  static const String forgotPassword = baseURL + "/Login/ForgotPassword?msisdn=_phoneNumber&hash=";
  static const String getusertype = baseURL + "/userregistration/getusertype";

  static const String updatePassword = baseURL + "/UserRegistration/UpdatePassword";
  static const String otpVerify = baseURL + "/userregistration/OtPverificationSync?msisdn=_phoneNumber";
  static const String fileUpload = baseURL + "/upload/data";
  static const String profileUpdate = baseURL + "/userregistration/UpdateProfileInfo";
  //static const String vehicleList = baseURL + "/vechile/GetVechileList?userid=_userId";
  static const String getVehicleType = baseURL + "/vechile/GetVechileType";



  static const String vehicleInfoAddUpdate = baseURL + "/vechile/VechileInfoAddUpdate";
  static const String addVehicleBrandModel = baseURL + "/vechile/InsertVechileGeneralInfo";
  static const String vehicleDocumentManager = baseURL + "/VechileDocumentManagement/Entry";
  static const String getDocumentHistory = baseURL + "/VechileDocumentManagement/GetDocumentList?vechileId=_vechileId&documentId=_documentId&ownerId=_ownerId";



  static const String garageList = baseURL + "/Garage/GetGarageList?userid=_userId";
  static const String garageInfoEntryUpdate = baseURL + "/Garage/GargeInfoEntryUpdate";
  static const String serviceInfo = baseURL + "/Service/Info";
  static const String getServiceListDropDown = baseURL + "/Service/GetServiceListDropDown?userid=_userId";

  static const String createServiceName = baseURL + "/Service/AddDataToServiceList";


  static const String getVehicleList = baseURL + "/vechile/GetvechileList?userid=_userId";
  static const String vehicleGeneralInfo = baseURL + "/vechile/VechileGeneralInfoList?infoId=_infoId&parentId=_parentId&VechileTypeForModelId=_vehicleTypeForModelId&ownerId=_ownerId";
  static const String getServicingList = baseURL + "/Service/GetServicingList?vechileId=_vehicleId&ownerId=_ownerId";
  static const String policeCaseList = baseURL + "/TripManagement/GetPoliceCaseList?vechileId=_vehicleId&ownerId=_ownerId";



  static const String getDriverList = baseURL + "/DriveInfo/GetDriveList?ownerId=_userId";
  static const String getAccidentList = baseURL + "/Accident/GetAccidentList?vechileId=_vehicleId&ownerId=_ownerId";
  static const String addUpdateAccident = baseURL + "/Accident/Entry";

  static const String getInsuranceList = baseURL + "/Insurance/GetInsuranceList?vechileId=_vehicleId";
  static const String addUpdateInsurance = baseURL + "/Insurance/Entry";

  static const String getFuelList = baseURL + "/Fuel/GetInsuranceList?ownerId=_ownerId";
  static const String addUpdateFuelList = baseURL + "/Fuel/Entry";

  static const String getVehicleEnergyType = baseURL + "/vechile/GetVechileEnergyType";
  static const String getExpenseReport = baseURL + "/Report/ExpenseReport";


  static const String addUpdatePoliceCase = baseURL + "/TripManagement/PoliceCase";
  static const String getPoliceFreezingDocList = baseURL + "/TripManagement/GetPoliceFreezingList?userid=_userId&ownerid=_ownerId";

  static const String updateFireBaseToken = baseURL + "/FireBase/Token";

  static const String tripList = baseURL + "/TripManagement/TripList?status=_statusId&ownerId=_ownerId";
  static const String addTripList = baseURL + "/TripManagement/Trip";
  static const String locationRequest = baseURL + "/Notification/LocationRequest?id=_tripId";
  static const String locationUpdate = baseURL + "/TripManagement/TripCurrentLocationUpdate";

  static const String notificationList = baseURL + "/Notification/Get?ownerId=_ownerId";
  static const String updateNotification = baseURL + "/Notification/SyncClicKTime?id=_id";
  static const String featureForHome = baseURL + "/Notification/GetMajorFeatureForHome?ownerId=_ownerId";

  static const String searchDriver = baseURL + "/DriverSelection/SearchDriver?mobileno=_mobileno&name=_name";

  static const String sendDriverAllocateRequest = baseURL + "/DriverSelection/SendDriverAllocateRequest?driverId=_driverId&ownerId=_ownerId&vechileId=_vechileId&hash=";
  static const String confirmDriverAllocateRequest = baseURL + "/DriverSelection/ConfirmDriverAllocateRequest?id=_id";

  static const String removeDriverFromAllocation = baseURL + "/DriverSelection/RemoveDriverFromAllocation?ownerId=_ownerId&driverId=_driverId";




}

