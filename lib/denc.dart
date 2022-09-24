import 'package:easy_encryption/easy_encryption.dart';

EasyEncryption easyEncrypt = new EasyEncryption();

Future<String> encryptMyMessage(String message) async {
  String encryptedMessage = await easyEncrypt.encryptData(data: message);

  return encryptedMessage;
}

Future<String> decryptMyMessage(String encryptedMessage) async {
  String originalMessage =
      await easyEncrypt.decryptData(data: encryptedMessage);

  return originalMessage;
}

// void main() async {
//   //String message = 'Hello World';
//   //String encryptedMessage = await encryptMyMessage(message);
//   String originalMessage = await decryptMyMessage(
//       'qpA3+raD9Ru9lWp8D3yOqhrqeeKPTQ59b1i5cR7iwCqEZzNN9qC5KbgoDFNL1wLbP02vqfDHxaIdzQHSEALOE1RN7lhM1TJqhRDl0Ez+pufIie/J/mQ5cHyZ53leRelpxmS6HNAtJ8zkRAjT7ngPWBDGqpYKJVMV33emVRlG6KaMUSpWP1BNKz1FdSRpSnxdZW1hJiZ2JEV2QyY7PDp4Pns=4JomqDhRJEvK3AVTU90tx46ojtuYrmsQmCUSe+V3q/CKeS3IHr5Hm4gTskDrTogKw6H3gML3MnsjAUziq84eLgDkbgsooz3RoR+Pz8QFFDi+apmPN2nyc9kEzFGnk6JktoTTE9AWkapj4LkmjMXSoMeDDDGjvZOqgEepIlzZ/w==');

//   // print('Original Message: $message');
//   // print('Encrypted Message: $encryptedMessage');
//   print('Original Message: $originalMessage');
// }
