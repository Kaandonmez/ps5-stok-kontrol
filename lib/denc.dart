import 'package:easy_encryption/easy_encryption.dart';

EasyEncryption easyEncrypt = EasyEncryption();

Future<String> encryptMyMessage(String message) async {
  String encryptedMessage = await easyEncrypt.encryptData(data: message);

  return encryptedMessage;
}

Future<String> decryptMyMessage(String encryptedMessage) async {
  String originalMessage =
      await easyEncrypt.decryptData(data: encryptedMessage);

  return originalMessage;
}
