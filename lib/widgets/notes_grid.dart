import 'package:flutter/material.dart';

import 'package:flutter_bloc_note_app/models/models.dart';
import 'package:intl/intl.dart';

class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note) onTap;
  const NotesGrid({
    Key key,
    @required this.notes,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 40.0,
        ),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, i) {
            final note = notes[i];
            return GestureDetector(
              onTap: () => onTap(note),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        note.content,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat.yMd().add_jm().format(note.timestamp),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }, childCount: notes.length),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8),
        ));
  }
}
