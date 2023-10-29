part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const WALKTHROUGH = _Paths.WALKTHROUGH;
  static const SIGNINUPPAGE = _Paths.SIGNINUPPAGE;
  static const EMAILAUTHENTICATIONPAGE = _Paths.EMAILAUTHENTICATIONPAGE;
  static const FORGOTPASSWORDPAGE = _Paths.FORGOTPASSWORDPAGE;
}

abstract class _Paths {
  static const WALKTHROUGH = '/walkthrough';
  static const SIGNINUPPAGE = '/sign-in-up';
  static const EMAILAUTHENTICATIONPAGE = '/email-authentication';
  static const FORGOTPASSWORDPAGE = '/forgot-password';
}