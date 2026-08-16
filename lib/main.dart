import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:saranya_rajagopalan_todo_app/application/search/bloc/search_bloc.dart';
import 'package:saranya_rajagopalan_todo_app/domain/search_request_model.dart';
import 'package:saranya_rajagopalan_todo_app/infrastructure/recent_searches_storage.dart';

import 'core/app_theme.dart';
import 'presentation/search/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SearchRequestModelAdapter());
  await Hive.openBox<SearchRequestModel>(RecentSearchesStorage.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => SearchBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const SearchScreen(),
      ),
    );
  }
}
