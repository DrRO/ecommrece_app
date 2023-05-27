class API
{

  /* Implement connection to server
   1- I Optain this IP by cmd >>> ipconfig
   2- then copy IPv4 Address
   3- create 'api_ecommrece_app' folder in this path C:\xampp\htdocs & write its name in hostConnect link*/

  static const hostConnect = "http://192.168.1.5/api_ecommrece_app";

  //signup & login user
  static const hostConnectUser = "$hostConnect/user";
  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signUp = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";

  //login admin
  static const hostConnectAdmin = "$hostConnect/admin";
  static const adminLogin = "$hostConnectAdmin/login.php";

  //Save_item_to database
  static const hostConnectItem = "$hostConnect/items";
  static const saveItem = "$hostConnectItem/save.php";

  //Products
  static const hostProducts = "$hostConnect/products";
  static const trendingProducts = "$hostProducts/trending.php";
  static const allProducts = "$hostProducts/allproducts.php";

  //cart
  static const hostCart = "$hostConnect/cart";

  static const addToCart = "$hostCart/add.php";
  static const getCartList = "$hostCart/read.php";
  static const deleteSelectedItemsFromCartList = "$hostCart/delete.php";
  static const updateItemInCartList = "$hostCart/update.php";
}