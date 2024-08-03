import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paygo_fit/core/enums/loading_states.dart';
import 'package:paygo_fit/src/home/data/models/center_details_model.dart';
import 'package:paygo_fit/src/home/data/repository/centers_data_repository.dart';

part 'centers_data_state.dart';

class CentersDataCubit extends Cubit<CentersDataState> {
  CentersDataCubit({
    required CentersDataRepository centersDataRepository,
  })  : _centersDataRepository = centersDataRepository,
        super(
          const CentersDataState(
            loadingStates: LoadingStates.initial,
            centersList: null,
            errorMessage: null,
          ),
        );

  final CentersDataRepository _centersDataRepository;

  Future<void> fetchCentersList() async {
    emit(
      state.copyWith(
        loadingStates: LoadingStates.loading,
      ),
    );
    await _centersDataRepository.getCentersList().then((result) {
      result.fold((failed) {
        emit(
          state.copyWith(
            loadingStates: LoadingStates.errorLoading,
            errorMessage: failed.errorMessage,
          ),
        );
      }, (liststream) {
        emit(
          state.copyWith(
            loadingStates: LoadingStates.loaded,
            centersList: liststream,
            errorMessage: null,
          ),
        );
      });
    });
  }

  Future<void> addListToDb(List<CenterDetails> list) async {
    await _centersDataRepository.addDefaultData(list: list);
  }
}
