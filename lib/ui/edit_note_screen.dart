import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/common/utils.dart';
import 'package:flutter_bloc_demo/model/note_model.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_bloc.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_event.dart';
import 'package:flutter_bloc_demo/notebloc/note_list_state.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteResponseData? data;
  const EditNoteScreen({super.key, this.data});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final title = TextEditingController();
  final content = TextEditingController();
  bool isPinned = false;
  bool isArchived = false;

  @override
  void initState() {
    if (widget.data != null) {
      title.text = widget.data!.title;
      content.text = widget.data!.content;
      isArchived = widget.data!.isArchived;
      isPinned = widget.data!.isPinned;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteListBloc, NoteListState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context, state.message);
        }
        if (state is SuccessState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            final note = NoteModel(
              id: widget.data?.id,
              title: title.text,
              content: content.text,
              isPinned: isPinned,
              isArchived: isArchived,
            );
            if (widget.data == null) {
              context.read<NoteListBloc>().add(AddNote(note));
            } else {
              context.read<NoteListBloc>().add(UpdateNote(note));
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Add note',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              actions: [
                if (widget.data != null)
                  IconButton(
                    onPressed: () {
                      context.read<NoteListBloc>().add(
                        DeleteNote(widget.data!.id),
                      );
                      Navigator.of(context).pop();
                    },
                    iconSize: 28,
                    icon: Icon(Icons.delete),
                  ),
                IconButton(
                  onPressed: () => setState(() => isPinned = !isPinned),
                  iconSize: 28,
                  icon: Icon(
                    isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => isArchived = !isArchived),
                  iconSize: 28,
                  icon: Icon(
                    isArchived ? Icons.archive : Icons.archive_outlined,
                  ),
                ),
              ],
            ),

            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Title',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: content,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Notes',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
