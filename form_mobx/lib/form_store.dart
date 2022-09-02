import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:validators2/validators.dart';

part 'form_store.g.dart';

class CustomColor extends Color {
  CustomColor(int color) : super(color);
}

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final FormErrorStore error = FormErrorStore();

  @observable
  String name = '';
  @observable
  String email = '';
  @observable
  String password = '';
  @computed
  bool get canLogin => !error.hasError;

  late List<ReactionDisposer> _disposers;

  void setupValidators() {
    _disposers = [
      reaction((_) => name, validateUsername),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @action
  void validateUsername(String value) {
    error.username = isNull(value) || value.isEmpty ? 'Cannot be empty' : null;
  }

  @action
  void validateEmail(String value) {
    error.email = isEmail(value) ? null : 'Not a valid email';
  }

  @action
  void validatePassword(String value) {
    error.password = isNull(value) || value.isEmpty
        ? 'Cannot be empty'
        : value.length < 8
            ? 'Password must be minimum 8 characters'
            : null;
  }

  void validateAll() {
    validateUsername(name);
    validatePassword(password);
    validateEmail(email);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? username;
  @observable
  String? email;
  @observable
  String? password;

  @computed
  bool get hasError => username != null || email != null || password != null;
}
