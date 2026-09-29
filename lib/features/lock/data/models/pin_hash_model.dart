import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_hash_model.freezed.dart';
part 'pin_hash_model.g.dart';

/// A stored PIN: PBKDF2-HMAC-SHA256 of the PIN with a random salt. The PIN
/// itself is never stored. [iterations] travels with the hash so it can be
/// raised later without breaking existing PINs.
@freezed
abstract class PinHashModel with _$PinHashModel {
  const factory PinHashModel({
    @Default(PinHashModel.pbkdf2Sha256) String algorithm,
    required int iterations,

    /// Base64.
    required String salt,

    /// Base64.
    required String hash,
  }) = _PinHashModel;

  factory PinHashModel.fromJson(Map<String, dynamic> json) =>
      _$PinHashModelFromJson(json);

  static const pbkdf2Sha256 = 'pbkdf2-hmac-sha256';
}
