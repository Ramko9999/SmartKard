import 'dart:convert';
import 'dart:io';

import 'package:minne_hack/utility/global.dart';
import 'package:path_provider/path_provider.dart';

class LocalCache {
  
  //initalizes the user
  static initUser(String name, String email) async {
    
    List<String> names = name.split(" ");
    Map fileData = {
        "firstName": names[0],
        "lastName": names[1],
        "email": email,
    };

    Directory appDirec = await getApplicationDocumentsDirectory();
    File contactInfo = File(appDirec.path + "/contacts.json");
    Global.userDataFile.writeAsStringSync(json.encode(fileData));

    Global.contactFile = contactInfo;
    Global.contactFile.writeAsStringSync(json.encode({}));
  }

  //return true or false based on whether the data is there or not
  static Future<bool> loadContactFile() async {
    Directory appDirec = await getApplicationDocumentsDirectory();
    File dataFile = File(appDirec.path + "/user.json");
    if (!dataFile.existsSync()) {
      dataFile.createSync();
    }
    Global.userDataFile = dataFile;
    String encContents = dataFile.readAsStringSync();
    if (encContents.length == 0) {
      Global.userDataFile.writeAsStringSync(json.encode({}));
      return false;
    }
    Map data = json.decode(encContents);
    if (data.keys.length == 0) {
      return false;
    }
    
    Global.contactFile = File(appDirec.path + "/contacts.json");
    return true;
  }
}
