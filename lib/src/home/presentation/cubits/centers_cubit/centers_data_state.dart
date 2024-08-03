part of 'centers_data_cubit.dart';

class CentersDataState extends Equatable {
  const CentersDataState({
    required this.centersList,
    required this.loadingStates,
    this.errorMessage,
  });

  final Stream<List<CenterDetails>>? centersList;
  final LoadingStates loadingStates;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        centersList,
        loadingStates,
        errorMessage,
      ];

  CentersDataState copyWith({
    Stream<List<CenterDetails>>? centersList,
    LoadingStates? loadingStates,
    String? errorMessage,
  }) {
    return CentersDataState(
      centersList: centersList ?? this.centersList,
      loadingStates: loadingStates ?? this.loadingStates,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
