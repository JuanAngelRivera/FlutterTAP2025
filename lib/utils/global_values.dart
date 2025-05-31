import 'package:flutter/widgets.dart';

class GlobalValues {
  static ValueNotifier<int> themeMode = ValueNotifier(1); // 1 día, 0 noche
  static String? sessionId; // Aquí guardas la sesión actual
}
