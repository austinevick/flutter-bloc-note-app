import 'package:flutter_bloc_note_app/models/models.dart';
import 'package:flutter_bloc_note_app/repositories/repositories.dart';

abstract class BaseNotesRepository extends BaseRepository {
  Future<Note> addNote({Note note});
  Future<Note> updateNote({Note note});
  Future<Note> deleteNote({Note note});
  Stream<List<Note>> streamNotes({String userId});
}
