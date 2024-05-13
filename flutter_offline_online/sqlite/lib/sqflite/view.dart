import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite/sqflite/controller.dart';
import 'package:sqlite/sqflite/models.dart';

// View
class NoteList extends ConsumerWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.push('/hh/hruu');
              },
              child: const Text('next'))
        ],
        title: const Text('Sqlite note'),
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text('No notes yet'),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteNoteDialog(note, context, ref),
                  ),
                  onTap: () => _showNoteDialog(note, context, ref),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showNoteDialog(null, context, ref),
      ),
    );
  }

  Future<void> _showNoteDialog(
    NoteModel? note,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final titleController = TextEditingController(text: note?.title);
    final contentController = TextEditingController(text: note?.content);

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: 'Content',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final title = titleController.text;
                final content = contentController.text;

                if (note == null) {
                  ref
                      .read(noteStateNotifierProvider.notifier)
                      .addNote(NoteModel(title: title, content: content));
                } else {
                  ref
                      .read(noteStateNotifierProvider.notifier)
                      .updateNote(NoteModel(
                        id: note.id,
                        title: title,
                        content: content,
                      ));
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteNoteDialog(
    NoteModel note,
    BuildContext context,
    WidgetRef ref,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: Text('Are you sure you want to delete "${note.title}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                ref
                    .read(noteStateNotifierProvider.notifier)
                    .deleteNote(note.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
