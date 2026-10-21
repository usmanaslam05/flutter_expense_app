import 'package:flutter_application/data/model/auth/auth_model.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';

extension AuthModelMapper on AuthModel {
  DataAuthModel toRemote(){
    return DataAuthModel(
      username: getEmail(),
      password: getPassword(),
    );
  }
}