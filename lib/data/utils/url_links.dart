class Urls {
  Urls._();

  static const String _baseURL = "http://10.0.2.2:3000";
  // static const String _baseURL = "http://127.0.0.1:3000";
  static String brandList = "$_baseURL/BrandList";
  static String categoryList = "$_baseURL/mbinu/category-list";

  static String userLogin = "$_baseURL/auth/signin";

  static String verifyOtp = '$_baseURL/auth/verify-login';
  static String completeProfile = "$_baseURL/mbinu/complete-profile";
  static String createProfile = "$_baseURL/mbinu/create-profile";
  static String userReadProfile = "$_baseURL/mbinu/read-profile";
  static String createCartList = "$_baseURL/mbinu/create-cart";
  static String homeScreenSlider = "$_baseURL/mbinu/products/home-feed";
  static String getCategories = '$_baseURL/mbinu/category-list';

  static String getProductsByRemarks(String remarks) =>
      '$_baseURL/mbinu/list-products/$remarks';

  static String getProductsDetails(int productsId) =>
      '$_baseURL/ProductDetailsById/$productsId';

  static const String addToCart = '$_baseURL/CreateCartList';
  static const String getCartList = '$_baseURL/mbinu/cart-list';
  static const String productWishList = '$_baseURL/ProductWishList';
  static String createWishList(int id) => '$_baseURL/CreateWishList/$id';
  static String listReviewById(int id) => '$_baseURL/ListReviewByProduct/$id';
  static const String createReview = '$_baseURL/CreateProductReview';
  static String deleteCartList(int productsId) =>
      '$_baseURL/DeleteCartList/$productsId';
}
