import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_290/bank/domain/bloc/bank_bloc.dart';
import 'package:forex_290/bank/domain/models/bank_model.dart';
import 'package:forex_290/bank/domain/repo/bank_repository.dart';
import 'package:forex_290/const/color.dart';
import 'package:forex_290/error/domain/bloc/error_bloc.dart';
import 'package:forex_290/firebase_options.dart';
import 'package:forex_290/history/domain/bloc/history_bloc.dart';
import 'package:forex_290/history/domain/model/history_model.dart';
import 'package:forex_290/history/domain/repository/hist_repo.dart';
import 'package:forex_290/home/domain/bloc/home_bloc.dart';
import 'package:forex_290/loading/domain/repositories/check_repo.dart';
import 'package:forex_290/loading/domain/repositories/loading_repo.dart';
import 'package:forex_290/loading/domain/repositories/remote_confige.dart';
import 'package:forex_290/loading/domain/repositories/services_repo.dart';
import 'package:forex_290/loading/view/bloc/load_bloc.dart';
import 'package:forex_290/nav_manager.dart';
import 'package:forex_290/news/domain/bloc/news_bloc.dart';
import 'package:forex_290/news/domain/repository/news_repo.dart';
import 'package:forex_290/splash.dart';
import 'package:forex_290/valute/domain/bloc/valute_bloc.dart';
import 'package:forex_290/valute/domain/repository/valute_repository.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([BankModelSchema, HistoryModelSchema],
      directory: appDir.path);
  final StreamController<String> errorController = StreamController();
  final BankRepository bankRepository = BankRepository(isar: isar);
  final ValuteRepository valuteRepository =
      ValuteRepository(isar: isar, errorController: errorController);
  final error = ErrorBloc(errorController: errorController);
  final NewsRepository newsRepository = NewsRepository();
  final VServices services = VServices();
  final HistoryRepository histRepo = HistoryRepository(isar: isar);
  final MyCheckRepo checkRepo = MyCheckRepo(errorController: errorController);
  final LoadingRepo onbordRepo = LoadingRepo(errorController: errorController);
  final FirebaseRemote firebaseRemote =
      FirebaseRemote(errorController: errorController);
  final navi = MyNavigatorManager.instance;
  final load = LoadBloc(
      servicesRepo: services,
      loadingRepo: onbordRepo,
      newsRepository: newsRepository,
      checkRepo: checkRepo,
      valuteRepository: valuteRepository,
      firebaseRemote: firebaseRemote,
      bankRepository: bankRepository)
    ..add(FirebaseRemoteInitEvent())
    ..add(NewsRepoInitEvent())
    ..add(BankRepoInitEvent());

  runApp(
    MyApp(
      navi: navi,
      histRepo: histRepo,
      valuteRepository: valuteRepository,
      load: load,
      newsRepository: newsRepository,
      checkRepo: checkRepo,
      firebaseRemote: firebaseRemote,
      onbordRepo: onbordRepo,
      bankRepository: bankRepository,
      error: error,
    ),
  );
}

class MyApp extends StatelessWidget {
  final MyCheckRepo checkRepo;
  final LoadingRepo onbordRepo;
  final FirebaseRemote firebaseRemote;
  final MyNavigatorManager navi;
  final HistoryRepository histRepo;
  final ValuteRepository valuteRepository;
  final LoadBloc load;
  final ErrorBloc error;
  final BankRepository bankRepository;
  final NewsRepository newsRepository;
  const MyApp({
    super.key,
    required this.histRepo,
    required this.navi,
    required this.newsRepository,
    required this.valuteRepository,
    required this.bankRepository,
    required this.load,
    required this.error,
    required this.checkRepo,
    required this.onbordRepo,
    required this.firebaseRemote,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => checkRepo,
        ),
        RepositoryProvider(
          create: (context) => onbordRepo,
        ),
        RepositoryProvider(
          create: (context) => firebaseRemote,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoadBloc>(
            create: (context) => load,
          ),
          BlocProvider<BankBloc>(
            create: (context) => BankBloc(bankRepo: bankRepository),
          ),
          BlocProvider<ValuteBloc>(
            lazy: false,
            create: (context) => ValuteBloc(repository: valuteRepository)
              ..add(GetValutePriceEvent()),
          ),
          BlocProvider<NewsBloc>(
            create: (context) => NewsBloc(newsRepository: newsRepository),
          ),
          BlocProvider<HistoryBloc>(
            lazy: false,
            create: (context) =>
                HistoryBloc(histRepo: histRepo)..add(GetHistoryEvent()),
          ),
          BlocProvider<ErrorBloc>(
            create: (context) => error,
          ),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navi.key,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: backgroundColor, elevation: 0),
            scaffoldBackgroundColor: backgroundColor,
            iconTheme: const IconThemeData(color: Colors.white),
            textTheme: const TextTheme(
              bodySmall: TextStyle(fontSize: 10),
              bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              labelSmall: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              displaySmall: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
              displayMedium: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700),
              labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          onGenerateRoute: navi.onGenerateRoute,
          initialRoute: SplashPage.routeName,
        ),
      ),
    );
  }
}
