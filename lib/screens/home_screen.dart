import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_note_app/blocs/blocs.dart';
import 'package:flutter_bloc_note_app/widgets/notes_grid.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        context.bloc<NotesBloc>()..add(FetchNotes());
      },
      builder: (context, authState) {
        return Scaffold(
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
                    : print('object'),
              ),
              actions: [
                IconButton(icon: Icon(Icons.brightness_4), onPressed: () {})
              ],
            ),
            notesState is NotesLoaded
                ? NotesGrid(
                    notes: notesState.notes,
                    onTap: (note) => print(note),
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
}
