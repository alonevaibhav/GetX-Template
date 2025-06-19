import 'package:get/get.dart';
import '../Auth/login_page.dart';
import 'app_bindings.dart';

class AppRoutes {
  // Route names
  static const login = '/login';


  static const cleaner = '/cleaner/dashboard';
  static const inspector = '/inspector/dashboard';


  static final routes = <GetPage>[


    ///------------------- Cleaner Routes -------------------///

    GetPage(
      name: login,
      page: () => const LoginView(),
      binding: AppBindings(),
    ),


    //Cle]aner routes
 ];}