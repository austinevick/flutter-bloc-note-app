import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_note_app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_note_app/blocs/blocs.dart';
import 'package:flutter_bloc_note_app/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc_note_app/repositories/notes/notes_repository.dart';
import 'package:flutter_bloc_note_app/screens/screens.dart';

import 'blocs/notes/notes_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemesBloc>(create: (_) => ThemesBloc()..add(LoadTheme())),
        BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
                  authRepository: AuthRepository(),
                )..add(AppStarted())),
        BlocProvider<NotesBloc>(
          create: (_) => NotesBloc(
              authRepository: AuthRepository(),
              notesRepository: NotesRepository()),
        )
      ],
      child: BlocBuilder<ThemesBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.themeData,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
