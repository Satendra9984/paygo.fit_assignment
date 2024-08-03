import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:paygo_fit/core/common/services/location.dart';
import 'package:paygo_fit/core/enums/loading_states.dart';

part 'user_location_state.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit()
      : super(
          const UserLocationState(
            locationLoadingState: LoadingStates.initial,
          ),
        );

  final LocationService _locationService = LocationService();

  void fetchCurrentAddress() async {
    emit(
      state.copyWith(
        locationLoadingState: LoadingStates.loading,
      ),
    );
    await _locationService.getCurrentLocationAddress().then(
      (result) {
        result.fold(
          (failed) {
            debugPrint('[log] : ${failed.errorMessage}');
            emit(
              state.copyWith(
                locationLoadingState: LoadingStates.errorLoading,
                errorMessage: failed.errorMessage,
              ),
            );
          },
          (data) {
            final (coordinates, address) = data;

            emit(
              state.copyWith(
                locationLoadingState: LoadingStates.errorLoading,
                errorMessage: null,
                coordinates: coordinates,
                address: address,
              ),
            );
          },
        );
      },
    );
  }
}
