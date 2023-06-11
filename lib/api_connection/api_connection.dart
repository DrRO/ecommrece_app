class API {
  // To get ip of your local host >>>> write ipconfig in cmd

  static const hostConnect = "http://192.168.1.8/api_ecommrece_store";
  static const hostImages = "$hostConnect/transactions_proof_images/";

  //signUp-Login user
  static const hostConnectUser = "$hostConnect/user";
  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const signUp = "$hostConnectUser/signup.php";
  static const login = "$hostConnectUser/login.php";

  //login admin
  static const hostConnectAdmin = "$hostConnect/admin";
  static const adminLogin = "$hostConnectAdmin/login.php";
  static const adminGetAllOrders = "$hostConnectAdmin/read_orders.php";

  //items
  static const hostItem = "$hostConnect/items";
  static const uploadNewItem = "$hostItem/upload.php";
  static const searchItems = "$hostItem/search.php";

  //Products
  static const hostProducts = "$hostConnect/products";
  static const getTrendingMostPopularProducts = "$hostProducts/trending.php";
  static const getAllProducts = "$hostProducts/all.php";

  //cart
  static const hostCart = "$hostConnect/cart";
  static const addToCart = "$hostCart/add.php";
  static const getCartList = "$hostCart/read.php";
  static const deleteSelectedItemsFromCartList = "$hostCart/delete.php";
  static const updateItemInCartList = "$hostCart/update.php";

  //favorite
  static const hostFavorite = "$hostConnect/favorite";
  static const validateFavorite = "$hostFavorite/validate_favorite.php";
  static const addFavorite = "$hostFavorite/add.php";
  static const deleteFavorite = "$hostFavorite/delete.php";
  static const readFavorite = "$hostFavorite/read.php";

  //order
  static const hostOrder = "$hostConnect/order";
  static const addOrder = "$hostOrder/add.php";
  static const readOrders = "$hostOrder/read.php";
  static const updateStatus = "$hostOrder/update_status.php";
}
