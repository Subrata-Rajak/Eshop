import '../../../domain/entity/user_entity.dart';

abstract class ProfileScreenStates {}

class ProfileScreenInitialState extends ProfileScreenStates {}

class ProfileScreenFetchingDataState extends ProfileScreenStates {}

class ProfileScreenDataFetchingSuccessState extends ProfileScreenStates {
  UserEntity? user;

  ProfileScreenDataFetchingSuccessState({required this.user});
}

class ProfileScreenSataFetchingErrorState extends ProfileScreenStates {}
