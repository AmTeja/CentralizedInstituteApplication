import 'package:cia/bloc_observer.dart';
import 'package:cia/blocs/blocs.dart';
import 'package:cia/config/routes.dart';
import 'package:cia/config/theme.dart';
import 'package:cia/firebase_options.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final authRepository = AuthRepository();
    final profileRepository = ProfileRepository();
    final promotionRepository = PromotionRepository();
    final attendanceRepository = AttendanceRepository();

    runApp(App(
      authRepository: authRepository,
      profileRepository: profileRepository,
      promotionRepository: promotionRepository,
      attendanceRepository: attendanceRepository,
    ));
  },
    blocObserver: AppBlocObserver()
  );
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final PromotionRepository _promotionRepository;
  final AttendanceRepository _attendanceRepository;

  const App({Key? key,
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
    required PromotionRepository promotionRepository,
    required AttendanceRepository attendanceRepository
  })
      : _authRepository = authRepository,
        _profileRepository = profileRepository,
        _promotionRepository = promotionRepository,
        _attendanceRepository = attendanceRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _authRepository),
          RepositoryProvider.value(value: _profileRepository),
          RepositoryProvider.value(value: _promotionRepository),
          RepositoryProvider.value(value: _attendanceRepository)
        ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppBloc(authRepository: _authRepository)),
          BlocProvider(create: (_) => ProfileBloc(profileRepository: _profileRepository)..add(LoadProfile())),
          BlocProvider(create: (_) => PromotionBloc(promotionRepository: _promotionRepository)..add(LoadPromotions())),
          BlocProvider(create: (_) => AttendanceBloc(attendanceRepository: _attendanceRepository)..add(LoadAttendance())),
          BlocProvider(create: (_) => AttendanceProfileBloc(attendanceRepository: _attendanceRepository)..add(LoadAttendanceProfile())),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: FlowBuilder(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages),
    );
  }
}
