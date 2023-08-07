import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/ui/pages/guide_home.dart';
import 'package:tourist_guide/ui/pages/home_page.dart';
import 'package:tourist_guide/ui/pages/login.dart';
class SharedPreferenceUtil {

      static final String loggedIn = "logged_in";
      static final String loggedOut = "logged_out";
      static final String loadingStatus = "loading";
      static final String initial = "initial";

      //static final String unknownUserType = "unknown";
      static final String touristType = "tourist";
      static final String guideType = "guide";

      static SharedPreferences? _sharedPreferences;
      static String  _userStatusKey = "user_status";
      static String _userTypeKey = "user_type";
      static String _userId = "user_id";
      static init() async{
        if(_sharedPreferences == null){
          _sharedPreferences = await SharedPreferences.getInstance();
        }
      }

      static changeUserSessionStatus(String currentStatus) async{
        print("Changing user session status to $currentStatus called in the shared preference");
        await init();
        _sharedPreferences!.setString(_userStatusKey, currentStatus);
      }

      static Future<String> getUserSessionStatus() async{
        print("Getting user session status from the shared preference");
        await init();
       return _sharedPreferences!.getString(_userStatusKey) ?? "asdfjaksldfas";
      }

      static changeUserType(String currentUserType) async{
        print("Changing user session status in the shared preference");
        await init();
        _sharedPreferences!.setString(_userTypeKey, currentUserType);
      }

      static Future<String> getUserType() async{
        print("Getting user session status from the shared preference");
        await init();
        return _sharedPreferences!.getString(_userTypeKey) ?? "";
      }

      static saveUserId(String userId) async{
        print("Changing user session status to in the shared preference");
        await init();
        _sharedPreferences!.setString(_userId, userId);
      }

      static Future<String> getUserId() async{
        print("Getting user session status from the shared preference");
        await init();
        return _sharedPreferences!.getString(_userId) ?? "";
      }

}