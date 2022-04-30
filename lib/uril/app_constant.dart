import 'package:amargari/model/RequestModel/request_service_model.dart';

class AppConstant {
  static String profileImageUrl = "";
  static String NidURL = "";

  static String BC_URL1 = "";
  static String BC_URL2 = "";

  static String CC_URL1 = "";
  static String CC_URL2 = "";

  static String DP_URL = "";
  static String BD_URL2 = "";

  static String fatherMobile = "";
  static String motherMobile = "";

  static String joiningDate = "";

  static String expenseImageURL = "";
  static String drivingLicenseURL = "";
  static String tradeLicenseURL = "";
  static String vehicleImageURL = "";
  static String accidentImageURL = "";
  static String insuranceImgURL = "";
  static String fuelSlipImgURL = "";
  static String docInsuranceImgURL = "";
  static String docTaxTokenImgURL = "";
  static String docFitnessImgURL = "";
  static String docRegistrationImgURL = "";
  static String docRoadPermitImgURL = "";
  static String policeCaseImageImgURL = "";
  static String expenseSlipURL = "";
  static String partsImageURL = "";

  void makeAllEmpty() {
    profileImageUrl = "";
    NidURL = "";
    BC_URL1 = "";
    BC_URL2 = "";
    CC_URL1 = "";
    CC_URL2 = "";
    DP_URL = "";
    BD_URL2 = "";
    drivingLicenseURL = "";
    tradeLicenseURL = "";
    vehicleImageURL = "";
    accidentImageURL = "";
    insuranceImgURL = "";
    fuelSlipImgURL = "";
  }

  static String profileImage = "profileImage";
  static String Nid = "Nid";
  static String drivingLicense = "drivingLicense";
  static String tradeLicense = "tradeLicense";
  static String vehicleImage = "vehicleImage";
  static String accidentImage = "accidentImage";
  static String insuranceImg = "insuranceImg";
  static String fuelSlipImg = "fuelSlipImg";
  static String docInsuranceImg = "Vehicle Insurance";
  static String docTaxTokenImg = "Vehicle TaxToken";
  static String docFitnessImg = "Vehicle Fitness";
  static String docRegistrationImg = "Vehicle Registration";
  static String docRoadPermitImg = "Vehicle Road Permit";
  static String policeCaseImageImg = "Police Case Image";
  static String expenseSlip = "ExpenseSlip";
  static String partsImage = "PartsImage";

  static int userId = 0;
  static int userTypeId = 0;

  static String ApiKey = "AIzaSyBJC85dIw6OmepJFtLdxiLfPSYApfXdc_g";

  static String startDate = "";
  static String endDate = "";

  static String serviceNameList = "serviceNameList";

  static List<RequestServiceModel> requestList = [];
}
