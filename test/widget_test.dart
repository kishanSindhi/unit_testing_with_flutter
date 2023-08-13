import 'package:auth_test/controller/auth_controlle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'controller/auth_controlle_test.mocks.dart';

/// to generate mocks we will use the following command
/// flutter pub run build_runner build
/// this will create auth_test_mock file and build with the help of
/// mockito plugin and build_runner plugin
/// you can call those mock classes by the MockClassName
/// for eg you have want to create mock class of ```UserModel```
/// ```@GenerateMocks([UserModel])
/// final user = MockUserModel();```
@GenerateMocks([FirebaseAuth, User])
void main() {
  final _auth = MockFirebaseAuth();
  final AuthController controller = AuthController(_auth);

  // calls every time b4 every test
  setUp(() async {
    controller.emailController.text = 'ksindhi474@gmail.com';
    controller.passwordController.text = '123456e';
  });

  /// this method will call after each and every test
  tearDown(() {
    controller.emailController.dispose();
    controller.passwordController.dispose();
  });

  /// suppose you do not want to execute each and every test
  /// you want to execute the test of only authentication then
  /// you can use group test. Instead of executing each and every
  /// test manually you can execute those test in group
  group('Auth', () {
    testWidgets('login', (_) async {
      /// this when method is called when we call ```signInWithEmailAndPassword```
      /// we can return the following things
      /// thenThrow for errors
      /// thenAnswer for answers and for errors
      /// thenReturn for successful test case
      when(
        _auth.signInWithEmailAndPassword(
          email: 'ksindhi474@gmail.com',
          password: '123456e',
        ),
      ).thenThrow(
        FirebaseAuthException(code: 'wrong-password'),
      );

      /// this expect method will check that the expected outcome
      /// and the original out come is same or not
      expect(await controller.logInWithEmailAndPassword(), 'Wrong password');
    });
  });
}
