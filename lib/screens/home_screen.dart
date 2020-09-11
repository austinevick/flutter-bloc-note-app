import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_note_app/blocs/blocs.dart';
import 'package:flutter_bloc_note_app/config/themes.dart';
import 'package:flutter_bloc_note_app/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc_note_app/repositories/notes/notes_repository.dart';
import 'package:flutter_bloc_note_app/widgets/notes_grid.dart';

import 'login_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        context.bloc<NotesBloc>()..add(FetchNotes());
      },
      builder: (context, authState) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider<NotesDetailBloc>(
                  child: NoteDetailScreen(),
                  create: (_) => NotesDetailBloc(
                    authBloc: context.bloc<AuthBloc>(),
                    notesRepository: NotesRepository(),
                  ),
                ),
              ),
            ),
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          body: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, noteState) =>
                  buildBody(context, authState, noteState)),
        );
      },
    );
  }

  Widget buildBody(
      BuildContext context, AuthState authState, NotesState notesState) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Your Notes'),
              ),
              leading: IconButton(
                iconSize: 28,
                icon: authState is Authenticated
                    ? Icon(
                        Icons.exit_to_app,
                      )
                    : Icon(Icons.account_circle),
                onPressed: () => authState is Authenticated
                    ? context.bloc<AuthBloc>().add(Logout())
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider<LoginBloc>(
                            create: (_) => LoginBloc(
                              authBloc: context.bloc<AuthBloc>(),
                              authRepository: AuthRepository(),
                            ),
                            child: LoginScreen(),
                          ),
                        ),
                      ),
              ),
              actions: [buildThemeIconbutton(context)],
            ),
            notesState is NotesLoaded
                ? NotesGrid(
                    notes: notesState.notes,
                    onTap: (note) =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider<NotesDetailBloc>(
                        child: NoteDetailScreen(
                          note: note,
                        ),
                        create: (_) => NotesDetailBloc(
                          authBloc: context.bloc<AuthBloc>(),
                          notesRepository: NotesRepository(),
                        )..add(NoteLoaded(note: note)),
                      ),
                    )),
                  )
                : const SliverPadding(padding: EdgeInsets.zero)
          ],
        ),
        notesState is NotesLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink(),
        notesState is NotesError
            ? Center(
                child: Text(
                  'Oops! something went wrong\nPlease check your connection',
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  buildThemeIconbutton(BuildContext context) {
    final bool isLightTheme = context.bloc<ThemesBloc>().state.themeData ==
        Themes.themeData[AppTheme.LightTheme];
    return IconButton(
        icon: isLightTheme
            ? Icon(
                Icons.brightness_4,
              )
            : Icon(
                Icons.brightness_5,
              ),
        onPressed: () => context.bloc<ThemesBloc>().add(UpdateTheme()));
  }
}
