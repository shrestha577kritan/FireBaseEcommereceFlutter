class Api {
  static const baseUrl = 'http://192.168.18.31:3000';
  static const userLogin = '$baseUrl/api/userLogin';
  static const signup = '$baseUrl/api/userSignUp';
  static const productAdd = '$baseUrl/api/create_product';
  static const productUpdate = '$baseUrl/api/product/update';
  static const productRemove = '$baseUrl/products/remove';
  static const getOrderHistory = '$baseUrl/order/history';
  static const orderCreate = '$baseUrl/order/order_create';
}
