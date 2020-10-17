part of 'services.dart';

class Network {
  static String serverToken =
      'AAAAL81B9QE:APA91bGYCEPthqZR017cB7vCqDU6ZdyFSWOJMregbI1rbf0XvKlyRLvT9lWozYzrYyZsMG7166JVKWAZOStEI66O3Zdqdo7n42MVaQb169Y1iA0OuVijHZ3v6nF1Kdjl7aUmRIZ92Yxj';
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  static Future<void> sendAndRetrieveMessage(tokenTo) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
print(tokenTo);
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Your Booking was be Approve',
            'title': 'Booking'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': tokenTo,
        },
      ),
    );

  //   final Completer<Map<String, dynamic>> completer =
  //       Completer<Map<String, dynamic>>();
  // print("wkwkw");
  //   firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       completer.complete(message);
  //       print("message");
  //       print(message);
  //     },
  //   );


    // return completer.future;
  }
}
