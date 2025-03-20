import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_bloc.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_state.dart';
import 'package:flutter_bloc_demo/common/utils.dart';
import 'package:flutter_bloc_demo/ui/edit_note_screen.dart';
import 'package:flutter_bloc_demo/ui/search_screen.dart';
import 'package:flutter_bloc_demo/widget/note_card.dart';

import '../notebloc/note_list_event.dart';
import 'archive_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    BlocProvider.of<NoteListBloc>(context).add(GetNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ArchiveNoteScreen()),
                ),
            iconSize: 28,
            icon: Icon(Icons.archive_outlined),
          ),
          IconButton(
            onPressed:
                () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => SearchScreen())),
            iconSize: 28,
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: BlocConsumer<NoteListBloc, NoteListState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, i) => NoteCard(data: state.notes[i]),
              ),
            );
          }
          if (state is ErrorState) {
            return MaterialButton(
              onPressed: () => context.read<NoteListBloc>().add(GetNotes()),
              child: Center(child: Text(state.message)),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(context, state.message);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed:
            () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => EditNoteScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
