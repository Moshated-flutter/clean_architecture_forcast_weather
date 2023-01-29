import '../../domain/entities/current_city_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CwStatus {}

class CwLoading extends CwStatus {}

class CwComplited extends CwStatus {
  final CurrentCityEntity currentCityEntity;

  CwComplited(this.currentCityEntity);
}

class CwError extends CwStatus {
  final String errorMessage;

  CwError(this.errorMessage);
}
