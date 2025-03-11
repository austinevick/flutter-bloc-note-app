import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/utils.dart';
import '../notebloc/note_list_bloc.dart';
import '../notebloc/note_list_event.dart';
import '../notebloc/note_list_state.dart';
import '../widget/note_card.dart';

class ArchiveNoteScreen extends StatefulWidget {
  const ArchiveNoteScreen({super.key});

  @override
  State<ArchiveNoteScreen> createState() => _ArchiveNoteScreenState();
}

class _ArchiveNoteScreenState extends State<ArchiveNoteScreen> {
  @override
  void initState() {
    context.read<NoteListBloc>().add(GetArchiveNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteListBloc, NoteListState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Archived',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: switch (state) {
              LoadingState() => Center(child: CircularProgressIndicator()),
              ErrorState() => Center(child: Text(state.message)),
              SuccessState() => ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, i) => NoteCard(data: state.notes[i]),
              ),
              NoteListState() => SizedBox(),
            },
          ),
        );
      },
    );
  }
}
