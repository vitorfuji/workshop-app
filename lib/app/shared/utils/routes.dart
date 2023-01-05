part of '../utils.dart';

class PodiPages {
  PodiPages._();

  // -> Forms
  static String formModule = "/forms/";
  static String userPage([bool complete = true]) =>
      complete ? "/forms/user/" : "/user/";
  static String questionPage([bool complete = true]) =>
      complete ? "/forms/questions/" : "/questions/";

  // -> Prizes
  static String prizesModule = "/prizes/";
  static String wheelPage([bool complete = true]) =>
      complete ? "/prizes/wheel/" : "/wheel/";
  static String redeemPage([bool complete = true]) =>
      complete ? "/prizes/redeem/" : "/redeem/";
}
