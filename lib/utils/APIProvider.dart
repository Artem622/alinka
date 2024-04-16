import 'package:alinka/utils/constants.dart';
import 'package:dio/dio.dart';

class APIProvider {
  final dio = Dio();

  var counter = 0;

  Future<String> firstRequest(String url, String message) async {
    final dio = Dio();
    print("SEND TO SERVER");
    print(message);
    final response = await dio.post(apiUrl1 + url, data: message, options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    ),);

    if(response.statusCode == 200) {
      return (
        response.data["reply"]
      );
    } else {
      if (counter > 10) {
        return "boob";
      }
      counter++;
      return firstRequest(url, message);
    }
  }
}
