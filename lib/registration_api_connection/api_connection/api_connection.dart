class API
{

  /* Implement connection to server
   1- I Optain this IP by cmd >>> ipconfig
   2- then copy IPv4 Address
   3- create 'api_ecommrece_app' folder in this path C:\xampp\htdocs & write its name in hostConnect link*/

  static const hostConnect = "http://192.168.1.5/api_ecommrece_app";
  static const hostConnectUser = "$hostConnect/user";

  //signup user
  static const validateEmail = "$hostConnect/user/validate_email.php";
static const signUp = "$hostConnect/user/signup.php";
}