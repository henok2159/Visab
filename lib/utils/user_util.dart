
class UserUtil{

  static String formatLanguagesList(List<String> langs){
      String formmated = "";
      int langsLength = langs.length;
      if(langsLength > 0){
      for(int i = 0; i < langsLength - 1; i++){
        formmated += langs[i].trim() + ', ';
      }
      formmated += langs[langsLength -1].trim();
      }

      return formmated;
  }


}