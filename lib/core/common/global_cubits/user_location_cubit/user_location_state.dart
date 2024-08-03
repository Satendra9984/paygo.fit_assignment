part of 'user_location_cubit.dart';

class UserLocationState extends Equatable {
  // Constructor
  const UserLocationState({
    this.coordinates,
    this.address,
    this.errorMessage,
    required this.locationLoadingState,
  });

  final Position? coordinates;
  final Placemark? address;
  final LoadingStates locationLoadingState;
  final String? errorMessage;
  // CopyWith method
  UserLocationState copyWith({
    Position? coordinates,
    Placemark? address,
    String? errorMessage,
    LoadingStates? locationLoadingState,
  }) {
    return UserLocationState(
      coordinates: coordinates ?? this.coordinates,
      address: address ?? this.address,
      locationLoadingState: locationLoadingState ?? this.locationLoadingState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        coordinates,
        address,
        locationLoadingState,
        errorMessage,
      ];
}
