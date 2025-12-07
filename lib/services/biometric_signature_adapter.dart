import 'package:flutter/foundation.dart';
import 'package:biometric_signature/biometric_signature.dart';
import 'package:biometric_signature/android_config.dart';
import 'dart:convert';

class BiometricSignatureAdapter {
  final BiometricSignature _bs = BiometricSignature();

  /// Returns a human-readable availability string or throws on error
  Future<String?> available() async {
    try {
      return await _bs.biometricAuthAvailable();
    } catch (e) {
      if (kDebugMode) debugPrint('biometric_signature available error: $e');
      return null;
    }
  }

  /// Ensure keys exist; returns public key (base64) or null on failure
  Future<String?> ensureKeys({bool useDeviceCredentials = true}) async {
    try {
      final androidConfig = AndroidConfig(useDeviceCredentials: useDeviceCredentials);
      final result = await _bs.createKeys(androidConfig: androidConfig);
      // In version 8.x, result is KeyCreationResult with publicKey property
      return result?.publicKey.toString();
    } catch (e) {
      if (kDebugMode) debugPrint('biometric_signature createKeys error: $e');
      return null;
    }
  }

  /// Prompt authentication and create signature for the payload. Returns non-null signature on success.
  /// Note: This method needs to be updated based on biometric_signature 8.x API documentation
  Future<String?> createSignature({required String payload, String promptMessage = 'Authenticate'}) async {
    try {
      // TODO: Update this method based on biometric_signature 8.1.1 API
      // The API has changed significantly in version 8.x
      // For now, this is a placeholder that returns null
      // Please refer to biometric_signature 8.x documentation for correct implementation
      if (kDebugMode) {
        debugPrint('biometric_signature createSignature: Needs API update for v8.1.1');
        debugPrint('Payload: $payload, Prompt: $promptMessage');
      }
      // Placeholder - return null until API is properly updated
      return null;
    } catch (e) {
      if (kDebugMode) debugPrint('biometric_signature createSignature error: $e');
      return null;
    }
  }

  /// Simulated local verification for demo purposes.
  /// In production verify the signature on the server using the public key.
  Future<bool> verifySignatureLocally({required String publicKeyBase64, required String payload, required String signatureBase64}) async {
    try {
      final pub = base64.decode(publicKeyBase64);
      final sig = base64.decode(signatureBase64);
      if (pub.isEmpty || sig.isEmpty) return false;
      // This is a simulation: we only check the decoded lengths. Real verification requires crypto.
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint('biometric_signature verify error: $e');
      return false;
    }
  }
}
