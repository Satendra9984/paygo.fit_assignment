import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paygo_fit/core/common/global_cubits/user_location_cubit/user_location_cubit.dart';
import 'package:paygo_fit/firebase_options.dart';
import 'package:paygo_fit/src/home/data/data_sources/remote_data_source.dart';
import 'package:paygo_fit/src/home/data/repository/centers_data_repository.dart';
import 'package:paygo_fit/src/home/presentation/cubits/centers_cubit/centers_data_cubit.dart';
import 'package:paygo_fit/src/home/presentation/pages/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CentersDataCubit(
            centersDataRepository: CentersDataRepository(
              remoteDataSource: RemoteDataSource(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => UserLocationCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DashboardScreen(),
      ),
    );
  }
}
