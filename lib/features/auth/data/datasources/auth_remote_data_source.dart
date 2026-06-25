import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> loginWithGoogle();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<String> loginWithGoogle() async {
    await GoogleSignIn.instance.initialize();
    final res = await GoogleSignIn.instance.authenticate();
    // todo! get the user auth info make a request to backend server and return token
    return res.id;
  }
}
