import 'dart:convert';
import 'dart:io';

import 'package:minne_hack/utility/global.dart';
import 'package:path_provider/path_provider.dart';

class LocalCache {
  
  //initalizes the user
  static initUser(String name, String email) async {
    
    List<String> names = name.split(" ");
    Map fileData = {
      "user": {
        "firstName": names[0],
        "lastName": names[1],
        "mail": email,
      },
      "contact": {}
    };

    Global.contactFile.writeAsStringSync(json.encode(fileData));
  }

  //return true or false based on whether the data is there or not
  static Future<bool> loadContactFile() async {
    print("Trying to load...");
    Directory appDirec = await getApplicationDocumentsDirectory();
    File dataFile = File(appDirec.path + "/data.json");
    if (!dataFile.existsSync()) {
      dataFile.createSync();
    }

    Global.contactFile = dataFile;
    String encContents = dataFile.readAsStringSync();
    print("Contacts:" + encContents);
    if (encContents.length == 0) {
      Global.contactFile.writeAsStringSync(json.encode({}));
      return false;
    }
    Map data = json.decode(encContents);
    if (data.keys.length == 0) {
      return false;
    }

    return true;
  }
}
