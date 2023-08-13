import 'package:auth_test/controller/auth_controlle.dart';
import 'package:auth_test/misc/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mockito/annotations.dart';

import 'package:flutter_test/flutter_test.dart';

import 'controller/auth_controlle_test.mocks.dart';

// class MockFirebaseUser extends Mock implements User {}

// final _mockUser = MockFirebaseUser();

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   @override
//   User? get currentUser => _mockUser;

//   @override
//   Stream<User?> authStateChanges() {
//     return Stream.fromIterable([
//       _mockUser,
//     ]);
//   }
// }

@GenerateMocks([FirebaseAuth, User])
void main() {
  final _auth = MockFirebaseAuth();
  final authController = AuthController(_auth);

  setUp(() async {
    logger.w('setup');
    // authController.emailController.text = 'ksindhi474@gmail.com';
    // authController.passwordController.text = '123456';
  });

  tearDown(() {
    logger.w('tear down');
  });

  test('login', () {
    expect(1, 1);
  });
}
