import 'package:flutter_dotenv/flutter_dotenv.dart';


/// For handling environment variable

class Env {
  static String IP = dotenv.env["IP"] ?? "<Server IP>";
  static String PORT = dotenv.env["PORT"] ?? "<Server PORT>";

  static String BASE_URI = "http://$IP:$PORT";
}