import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_bloc.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_event.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_state.dart';

import '../widget/note_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTerm = TextEditingController();

  Timer? debounce;

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<NoteListBloc>().add(SearchNote(query));
    });
  }

  @override
  void dispose() {
    debounce!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListBloc, NoteListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: searchTerm,
              autofocus: true,
              onChanged: onSearchChanged,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
          ),
        );
      },
    );
  }
}
