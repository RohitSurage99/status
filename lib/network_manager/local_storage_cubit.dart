import 'package:flutter_bloc/flutter_bloc.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit() : super(StorageInitial());
  Storage storage = Storage();
  void updateStorage(String name, String image, String phone, String email) {
    storage.name = name;
    storage.profileImage = image;
    storage.phone = phone;
    storage.email = email;
    emit(StorageUpdated(storage));
  }

  void clearStorage() {
    storage.name = '';
    storage.profileImage = '';
    storage.phone = '';
    storage.email = '';
    emit(StorageUpdated(storage));
  }

}


//------state ---------

abstract class StorageState {}

class StorageInitial extends StorageState {}

class StorageUpdated extends StorageState {
  final Storage storage;
  StorageUpdated(this.storage);
}

class Storage {
  String name = '';
  String profileImage = '';
  String phone = '';
  String email = '';
}


