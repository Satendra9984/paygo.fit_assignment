import 'package:fpdart/fpdart.dart';
import 'package:paygo_fit/core/errors/failure.dart';
import 'package:paygo_fit/src/home/data/data_sources/remote_data_source.dart';
import 'package:paygo_fit/src/home/data/models/center_details_model.dart';

class CentersDataRepository {
  CentersDataRepository({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final RemoteDataSource _remoteDataSource;

  Future<Either<Failure, Stream<List<CenterDetails>>>> getCentersList() async {
    try {
      final list = _remoteDataSource.getNearbyCentersList();

      return Right(list);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Something went wrong while fetching centers nearby.',
          statusCode: 400,
        ),
      );
    }
  }

  Future<void> addDefaultData({
    required List<CenterDetails> list,
  }) async {
    for (final center in list) {
      try {
        await _remoteDataSource.addCenterDetails(center);
      } catch (e) {
        // not our concern for test data to handle
      }
    }
  }
}
