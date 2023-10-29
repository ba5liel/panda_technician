import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:panda_technician/amplifyconfiguration.dart';

class PandaAmplify {
  static Future<void> configureAmplify() async {
    // final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(AmplifyAPI());

    try {
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }
}
