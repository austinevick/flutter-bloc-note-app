import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/api/api.dart';
import 'package:flutter_bloc_demo/api/http_client.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_event.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_state.dart';
import 'package:flutter_bloc_demo/repository/note_repository.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NoteRepository noteRepository;

  NoteListBloc(this.noteRepository) : super(InitialState()) {
    on<GetNotes>(getNotes);
    on<GetArchiveNotes>(getArchiveNotes);
    on<AddNote>(addNote);
    on<UpdateNote>(updateNote);
    on<DeleteNote>(deleteNote);
  }

  FutureOr<void> getNotes(GetNotes event, Emitter<NoteListState> emit) async {
    try {
      emit(LoadingState());
      final response = await noteRepository.getNotes();
      emit(SuccessState(response.data!, response.message));
    } catch (e) {
      emit(ErrorState(somethingWentWrong));
    }
  }

  FutureOr<void> getArchiveNotes(
    GetArchiveNotes event,
    Emitter<NoteListState> emit,
  ) async {
    try {
      emit(LoadingState());
      final response = await noteRepository.getArchiveNotes();
      emit(SuccessState(response.data!, response.message));
    } catch (e) {
      emit(ErrorState(somethingWentWrong));
    }
  }

  Future<void> addNote(AddNote event, Emitter<NoteListState> emit) async {
    if (event.note.title.isEmpty && event.note.content.isEmpty) return;
    try {
      emit(LoadingState());
      final response = await noteRepository.addNotes(event.note);
      if (response.status == 201) {
        final notes = await noteRepository.getNotes();
        emit(SuccessState(notes.data!, response.message));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> updateNote(UpdateNote event, Emitter<NoteListState> emit) async {
    try {
      emit(LoadingState());
      final response = await noteRepository.updateNote(event.note);
      if (response.status == 200) {
        final notes = await noteRepository.getNotes();
        emit(SuccessState(notes.data!, response.message));
      }
    } catch (e) {
      logger.d(e);
      emit(ErrorState(somethingWentWrong));
    }
  }

  Future<void> deleteNote(DeleteNote event, Emitter<NoteListState> emit) async {
    try {
      emit(LoadingState());
      final response = await noteRepository.deleteNote(event.id);
      if (response.status == 200) {
        final notes = await noteRepository.getNotes();
        emit(SuccessState(notes.data!, response.message));
      }
    } catch (e) {
      logger.d(e);
      emit(ErrorState(somethingWentWrong));
    }
  }
}
