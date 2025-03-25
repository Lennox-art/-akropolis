import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

abstract class UserRepository {

  Future<Result<AppUser>> saveAppUser({required AppUser appUser});

  Future<Result<AppUser?>> findUserById({required String id});

  Future<Result<List<AppUser>>> searchByDisplayName({required String query});

}