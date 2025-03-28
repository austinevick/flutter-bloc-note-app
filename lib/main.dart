import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/authbloc/auth_bloc.dart';
import 'package:flutter_bloc_demo/common/utils.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_bloc.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_event.dart';
import 'package:flutter_bloc_demo/repository/note_repository.dart';
import 'package:flutter_bloc_demo/ui/auth_screen.dart';

import 'authbloc/auth_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(NoteRepository())..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => NoteListBloc(NoteRepository())..add(GetNotes()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        navigatorKey: navigatorKey,
        home: const AuthScreen(),
      ),
    );
  }
}
