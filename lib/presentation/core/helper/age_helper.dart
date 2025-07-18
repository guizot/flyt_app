class AgeHelper {

  int? calculateAge(String birthdate) {
    try {
      final parts = birthdate.split(' ');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final monthMap = {
          'jan': 1,
          'feb': 2,
          'mar': 3,
          'apr': 4,
          'may': 5,
          'jun': 6,
          'jul': 7,
          'aug': 8,
          'sep': 9,
          'oct': 10,
          'nov': 11,
          'dec': 12,
        };
        final month = monthMap[parts[1].toLowerCase()] ?? 1;
        final year = int.parse(parts[2]);
        final birth = DateTime(year, month, day);
        final now = DateTime.now();
        int age = now.year - birth.year;
        if (now.month < birth.month ||
            (now.month == birth.month && now.day < birth.day)) {
          age--;
        }
        return age;
      }
    } catch (_) {}
    return null;
  }

}
