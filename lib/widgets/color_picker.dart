import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_note_app/blocs/blocs.dart';

class ColorPicker extends StatelessWidget {
  final NoteDetailState state;
  final List<Color> color;
  const ColorPicker({
    Key key,
    this.state,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: color.map((color) {
          bool isSelected = state.note != null && state.note.color == color;
          return GestureDetector(
              onTap: () => context
                  .bloc<NotesDetailBloc>()
                  .add(NoteColorUpdated(color: color)),
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: isSelected
                        ? Border.all(color: Colors.black, width: 2)
                        : null),
              ));
        }).toList(),
      ),
    );
  }
}
