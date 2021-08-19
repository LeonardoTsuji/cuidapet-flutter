import 'package:cuidapet/app/models/facebook_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookRepository {
  Future<FacebookModel?> login() async {
    final result = await FacebookAuth.instance.login(
      permissions: [
        'public_profile',
        'email',
      ],
    );

    switch (result.status) {
      case LoginStatus.success:
        final token = result.accessToken?.token;
        final userData = await FacebookAuth.i.getUserData(
          fields: "picture, email",
        );
        var model = FacebookModel.fromJson(userData);
        model.token = token;
        return model;
        break;
      case LoginStatus.cancelled:
        return null;
        break;
      case LoginStatus.failed:
        throw Exception(result.message);
        break;
      case LoginStatus.operationInProgress:
        // TODO: Handle this case.
        break;
    }
  }
}
