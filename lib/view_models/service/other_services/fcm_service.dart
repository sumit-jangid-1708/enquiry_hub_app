import 'package:flutter/cupertino.dart';
import '../../../data/network/network_api_service.dart';

class FcmService {
  final NetworkApiServices _apiService = NetworkApiServices();

  // ✅ Sabhi venture backends ki list
  static const List<String> _backends = [
    'https://www.bbsmituni.com/api/save-device-token',
    'https://www.ahitechno.com/api/ahit/save-device-token',
    'https://www.tourmonks.com/api/tour/save-device-token',
    'https://www.ahecounselling.com/api/ahec/save-device-token' // Ensure this URL is correct
  ];

  Future<Map<String, dynamic>> sendFcmToken(String fcmToken) async {
    final body = {"token": fcmToken, "device_name": "Android"};
    bool anySuccess = false;

    for (final url in _backends) {
      try {
        debugPrint('🚀 Sending token to: $url');
        await _apiService.postApi(body, url);
        debugPrint('✅ Token saved successfully to: $url');
        anySuccess = true;
      } catch (e) {
        // Log error but continue for other backends
        debugPrint('❌ Failed to save token to: $url. Error: $e');
      }
    }

    return {
      'success': anySuccess,
      'message': anySuccess ? 'Token process completed' : 'All backend calls failed'
    };
  }
}
