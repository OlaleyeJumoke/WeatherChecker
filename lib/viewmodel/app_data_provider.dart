// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

// import '../Exceptions/api_failure_exception.dart';
// import '../helper/network_helper.dart';
// import '../models/app_model.dart';
// import '../repository/hive_repository.dart';
// import '../utils/constants.dart';

// class AppData {
//   late AppModel _appModel;

//   AppModel get appModel => _appModel;
//   setAppModel(AppModel am) => _appModel = am;

//   NetworkHelper _helper = NetworkHelper();
//   HiveRepository _hiveRepository = HiveRepository();

//   static AppData appDataProvider(BuildContext context, {bool listen = false}) =>
//       Provider.of<AppData>(context, listen: listen);

//   Future<void> getOrUpdateDeviceToke(String userId, String token) async {
//     String dt;
//     try {
//       if (appModel.deviceToken.isEmpty) {
//         //get token from server
//         dt = await _helper.getDeviceToken(userId, token);
//         if (dt == null) {
//           //update users device token
//           dt = await _helper.updateDeviceToken(userId, token);
//           if (dt == null) return;
//         }
//         AppModel newAppModel = AppModel(
//             lastRoute: _appModel.lastRoute,
//             deviceToken: _appModel.deviceToken,
//             token: _appModel.token);
//         _hiveRepository.add<AppModel>(
//             name: kAppDataName, key: 'me', item: newAppModel);
//         _appModel = newAppModel;
//       }
//     } catch (ex) {
//       throw ApiFailureException(ex);
//     }
//   }
// }
