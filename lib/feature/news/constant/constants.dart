import 'package:nepali_utils/nepali_utils.dart';

class Months {
  static const Map<int, String> month = {
    1: "Baisakh",
    2: "Jesth",
    3: "Asar",
    4: "Sawan",
    5: "Bhadau",
    6: "Aaswin",
    7: "Kartik",
    8: "Mangsir",
    9: "Push",
    10: "Magh",
    11: "Falgun",
    12: "Chait",
  };

  static List<String> monthsList = month.entries.map((e) => e.value).toList();
}

class Year {
  static int currentYear = NepaliDateTime.now().year;
  static List<String> yearList = [];

  static get getListYear {
    for (int i = 0; i < 20; i++) {
      yearList.add((currentYear - i).toString());
    }

    return yearList;
  }
}
