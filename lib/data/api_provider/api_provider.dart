import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<String> sendNotificationToUsers({
    String? topicName,
    String? fcmToken,
    required String title,
    required String body,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Authorization":
              "key=AAAAyKAPj5U:APA91bH_OBbLeUMBsprC-Zywz0NWcdFTJxov3qjYJdQ6nLjRJzGbHW6v-w3GIkMsZwvpxoUcoK4gxde3ngUovtkXsgfm8JYxpzGIgl58B6v-_wucEjx4Pi0NFJPUGxVQZzPqee91dJXg",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "to": topicName != null ? "/topics/$topicName" : "clAx9I8OTuyHEXVGu8WYqs:APA91bFX4X-8SxxbGPI465wObH1_G1zB-Yyok_HQZpEy5Rz5-cxps1zJtI6eJfatDNGMPVAWFtXYkVSmTxvbdxzAqgDxm-UJoVAmzPJn7erZscrUHMCsHVerWw8tdEhhhf-n1A76bBew",
            "notification": {
              "title": title,
              "body": body,
              "sound": "default",
              "priority": "high"
            },
            "data": {
              "news_image":
                  "https://top.uz/upload/iblock/0de/0dec725e4583a0698a8732ca646a4994.png",
              "news_title": "Test",
              "news_text":
                  "Finland's national carrier Finnair has started weighing passengers on its flights from the capital city of Helsinki. The weigh-ins are being done on a voluntary basis and are completely anonymous. A company spokesperson said the new initiative is to ensure safety standards on flights are adhered to. He said any airplane should not exceed the prescribed maximum weight for safe take-offs and landings."
            }
          },
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("DATA:${response.body}");
        return response.body.toString();
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return "ERROR";
  }
}
