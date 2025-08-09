import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openWhatsApp(String phoneNumber, {String? message}) async {
  try {
    // Remove any non-digit characters from phone number
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), "");

    // Add country code if not present (assuming Egypt +20)
    final phoneWithCode = cleanPhone.startsWith('20')
        ? cleanPhone
        : '20$cleanPhone';

    // Base WhatsApp URL
    String whatsappUrl = 'https://wa.me/$phoneWithCode';

    // Add message if provided
    if (message != null && message.isNotEmpty) {
      final encodedMessage = Uri.encodeComponent(message);
      whatsappUrl += '?text=$encodedMessage';
    }

    final uri = Uri.parse(whatsappUrl);

    // Launch WhatsApp
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }

    return false;
  } catch (e) {
    debugPrint('Error opening WhatsApp: $e');
    return false;
  }
}
