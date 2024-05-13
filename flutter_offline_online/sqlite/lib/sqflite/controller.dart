// StateNotifier (Controller)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite/sqflite/database.dart';
import 'package:sqlite/sqflite/models.dart';

final noteStateNotifierProvider =
    StateNotifierProvider<NoteStateNotifier, List<NoteModel>>((ref) {
  return NoteStateNotifier();
});

class NoteStateNotifier extends StateNotifier<List<NoteModel>> {
  NoteStateNotifier() : super([]) {
    getNotes();
  }

  Future<void> getNotes() async {
    final notes = await DatabaseHelper.instance.getNotes();
    state = notes;
  }

  Future<void> addNote(NoteModel noteModel) async {
    await DatabaseHelper.instance.addNote(noteModel);
    await getNotes();
  }

  Future<void> updateNote(NoteModel noteModel) async {
    await DatabaseHelper.instance.updateNote(noteModel);
    await getNotes();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper.instance.deleteNote(id);
    await getNotes();
  }
}
