import 'package:firebase_auth/firebase_auth.dart';

/// A simplified representation of [User] from the `firebase_auth` package.
///
/// This model exposes the common properties that are typically consumed by the
/// app. It can be constructed directly or created from a [User] instance
/// provided by Firebase.
class AppUser {
  /// Unique identifier for the user.
  final String uid;

  /// The user's email address, if available.
  final String? email;

  /// Whether the user's email address has been verified.
  final bool emailVerified;

  /// The user's display name, if available.
  final String? displayName;

  /// The URL to the user's profile photo, if set.
  final String? photoURL;

  /// The user's phone number, if available.
  final String? phoneNumber;

  /// Indicates if the user signed in anonymously.
  final bool isAnonymous;

  /// Timestamp when the account was created, if known.
  final DateTime? creationTime;

  /// Timestamp of the last sign in, if known.
  final DateTime? lastSignInTime;

  /// The tenant ID associated with the user, if set.
  final String? tenantId;

  /// Provider specific user data such as Google or Apple sign-in details.
  final List<UserInfo> providerData;

  const AppUser({
    required this.uid,
    this.email,
    required this.emailVerified,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    required this.isAnonymous,
    this.creationTime,
    this.lastSignInTime,
    this.tenantId,
    this.providerData = const [],
  });

  /// Creates an [AppUser] instance from Firebase's [User].
  factory AppUser.fromFirebase(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      emailVerified: user.emailVerified,
      displayName: user.displayName,
      photoURL: user.photoURL,
      phoneNumber: user.phoneNumber,
      isAnonymous: user.isAnonymous,
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
      tenantId: user.tenantId,
      providerData: user.providerData,
    );
  }
}
