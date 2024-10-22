import 'package:car_workshop/core/constants/app_strings.dart';
import 'package:car_workshop/core/enums/user_role.dart';
import 'package:car_workshop/features/auth/data/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final GetStorage storage;
  static const String _currentUserKey = AppStrings.loggedUser;

  AuthService(this.storage) {
    _loadCurrentUser();
  }

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool get isMechanic => _currentUser?.role == UserRole.mechanic;

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    _saveCurrentUser(user);
  }

  void _saveCurrentUser(UserModel user) {
    storage.write(_currentUserKey, user.toJson());
  }

  void _loadCurrentUser() {
    final userData = storage.read<Map<String, dynamic>>(_currentUserKey);
    if (userData != null) {
      _currentUser = UserModel.fromJson(userData);
    }
  }

  void clearCurrentUser() {
    _currentUser = null;
    storage.remove(_currentUserKey);
  }
}
