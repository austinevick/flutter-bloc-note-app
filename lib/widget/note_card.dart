import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/model/note_model.dart';

import '../notebloc/note_list_bloc.dart';
import '../notebloc/note_list_event.dart';
import '../ui/edit_note_screen.dart';

class NoteCard extends StatelessWidget {
  final NoteResponseData data;
  const NoteCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<NoteListBloc>(context);
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditNoteScreen(data: data)),
          ),
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (data.title.isNotEmpty)
                    Text(
                      data.title,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  if (data.isPinned) Icon(Icons.push_pin),
                ],
              ),
              Text(
                data.content,
                maxLines: 3,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TimeOfDay.fromDateTime(data.createdAt!).format(context),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => provider.add(DeleteNote(data.id)),
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
