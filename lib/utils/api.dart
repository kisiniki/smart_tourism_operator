class AppUrl {
  static const String _baseUrl = 'http://sepedapintar.tubaba.go.id';
  //PROFILE
  static const String getProfileAPI = '$_baseUrl/api/user';
  //AUTH
  static const String loginAPI = '$_baseUrl/api/user/login';
  static const String registerAPI = '$_baseUrl/api/user/register';
  static const String logoutAPI = '$_baseUrl/api/user/logout';
  //VEHICLE AND RENTAL
  static const String getAllVehicleAPI = '$_baseUrl/api/user/vehicle/rental/all';
  static String getVehicleDetailAPI(var id){
    return '$_baseUrl/api/user/vehicle/$id';}
  static String getVehicleRentalDetailAPI(int idVehicle, int idRental){
    return '$_baseUrl/api/user/vehicle/$idVehicle/rental/$idRental';}
  static String getAllRentalAPI = '$_baseUrl/api/user/vehicle/rental/all';
  static String rentAPI(var id){
    return '$_baseUrl/api/user/vehicle/$id/rent';}
  static String getVehicleTypeAPI(var id){
    return '$_baseUrl/api/user/vehicle/vehicle-type/$id';}
}