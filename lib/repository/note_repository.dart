import 'dart:convert';

import 'package:flutter_bloc_demo/api/api_endpoint.dart';
import 'package:flutter_bloc_demo/api/http_client.dart';
import 'package:flutter_bloc_demo/model/auth_model.dart';
import 'package:flutter_bloc_demo/model/note_model.dart';

class NoteRepository {
  Future<AuthResponseModel> login(AuthModel auth) async {
    final response = await HttpClient.postRequest(
      ApiEndpoint.login,
      body: auth.toMap(),
    );
    final json = jsonDecode(response.body);
    return AuthResponseModel.fromJson(json);
  }

  Future<AuthResponseModel> register(AuthModel auth) async {
    final response = await HttpClient.postRequest(
      ApiEndpoint.register,
      body: auth.toMap(),
    );
    final json = jsonDecode(response.body);
    return AuthResponseModel.fromJson(json);
  }

  Future<NoteResponseModel> getNotes() async {
    final response = await HttpClient.getRequest(ApiEndpoint.note);
    final json = jsonDecode(response.body);
    return NoteResponseModel.fromJson(json);
  }

  Future<NoteResponseModel> getArchiveNotes() async {
    final response = await HttpClient.getRequest(ApiEndpoint.archiveNotes);
    final json = jsonDecode(response.body);
    return NoteResponseModel.fromJson(json);
  }

  Future<NoteResponseModel> addNotes(NoteModel note) async {
    final response = await HttpClient.postRequest(
      ApiEndpoint.note,
      body: note.toMap(),
    );
    final json = jsonDecode(response.body);
    return NoteResponseModel.fromMap(json);
  }

  Future<NoteResponseModel> updateNote(NoteModel note) async {
    final response = await HttpClient.putRequest(
      "${ApiEndpoint.note}/${note.id}",
      body: note.toMap(),
    );
    logger.d(note.toString());
    final json = jsonDecode(response.body);
    return NoteResponseModel.fromMap(json);
  }

  Future<NoteResponseModel> deleteNote(String id) async {
    final response = await HttpClient.deleteRequest("${ApiEndpoint.note}/$id");
    final json = jsonDecode(response.body);
    return NoteResponseModel.fromMap(json);
  }
}
