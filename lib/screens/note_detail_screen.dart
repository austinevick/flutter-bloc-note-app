import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc_note_app/blocs/blocs.dart';

import 'package:flutter_bloc_note_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;
  const NoteDetailScreen({
    Key key,
    this.note,
  }) : super(key: key);
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _contentFocusNode = FocusNode();
  final _contentController = TextEditingController();
  bool get _isEditing => widget.note != null;
  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _contentController.text = widget.note.content;
    } else {
      SchedulerBinding.instance.addPostFrameCallback(
          (_) => FocusScope.of(context).requestFocus(_contentFocusNode));
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_isEditing) {
          context.bloc<NotesDetailBloc>().add(NoteSaved());
        }
        return Future.value(true);
      },
      child: BlocConsumer<NotesDetailBloc, NoteDetailState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.of(context).pop();
          } else if (state.isFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(state.errorMessage),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'))
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                actions: [buildAction()],
                elevation: 0.0,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 10.0,
                  bottom: 80.0,
                ),
                child: TextField(
                  focusNode: _contentFocusNode,
                  controller: _contentController,
                  style: const TextStyle(fontSize: 18, height: 1.2),
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Write about something :)'),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) => context
                      .bloc<NotesDetailBloc>()
                      .add(NoteContentUpdated(content: value)),
                ),
              ));
        },
      ),
    );
  }

  buildAction() {
    return _isEditing
        ? FlatButton(
            onPressed: () => context.bloc<NotesDetailBloc>().add(NoteDeleted()),
            child: Text(
              'Delete',
              style: const TextStyle(fontSize: 17, color: Colors.red),
            ))
        : FlatButton(
            onPressed: () => context.bloc<NotesDetailBloc>().add(NoteAdded()),
            child: Text(
              'Add Note',
              style: const TextStyle(fontSize: 17, color: Colors.green),
            ));
  }
}
