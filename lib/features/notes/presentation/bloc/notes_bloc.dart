import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/note_model.dart';
import '../../data/repositories/notes_repository.dart';

// Events
abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesFetch extends NotesEvent {}

class NotesAdd extends NotesEvent {
  final String text;

  const NotesAdd({required this.text});

  @override
  List<Object> get props => [text];
}

class NotesUpdate extends NotesEvent {
  final String id;
  final String text;

  const NotesUpdate({required this.id, required this.text});

  @override
  List<Object> get props => [id, text];
}

class NotesDelete extends NotesEvent {
  final String id;

  const NotesDelete({required this.id});

  @override
  List<Object> get props => [id];
}

// States
abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesOperationLoading extends NotesState {
  final List<Note> notes;

  const NotesOperationLoading({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesLoaded extends NotesState {
  final List<Note> notes;

  const NotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesError extends NotesState {
  final String message;

  const NotesError({required this.message});

  @override
  List<Object> get props => [message];
}

class NotesOperationSuccess extends NotesState {
  final List<Note> notes;
  final String message;

  const NotesOperationSuccess({required this.notes, required this.message});

  @override
  List<Object> get props => [notes, message];
}

// Bloc
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc(this._notesRepository) : super(NotesInitial()) {
    on<NotesFetch>(_onFetch);
    on<NotesAdd>(_onAdd);
    on<NotesUpdate>(_onUpdate);
    on<NotesDelete>(_onDelete);
  }

  Future<void> _onFetch(NotesFetch event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await _notesRepository.fetchNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }

  Future<void> _onAdd(NotesAdd event, Emitter<NotesState> emit) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      emit(NotesOperationLoading(notes: currentState.notes));
    }
    
    try {
      await _notesRepository.addNote(event.text);
      final notes = await _notesRepository.fetchNotes();
      emit(NotesOperationSuccess(
        notes: notes,
        message: 'Note added successfully',
      ));
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }

  Future<void> _onUpdate(NotesUpdate event, Emitter<NotesState> emit) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      emit(NotesOperationLoading(notes: currentState.notes));
    }
    
    try {
      await _notesRepository.updateNote(event.id, event.text);
      final notes = await _notesRepository.fetchNotes();
      emit(NotesOperationSuccess(
        notes: notes,
        message: 'Note updated successfully',
      ));
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }

  Future<void> _onDelete(NotesDelete event, Emitter<NotesState> emit) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      emit(NotesOperationLoading(notes: currentState.notes));
    }
    
    try {
      await _notesRepository.deleteNote(event.id);
      final notes = await _notesRepository.fetchNotes();
      emit(NotesOperationSuccess(
        notes: notes,
        message: 'Note deleted successfully',
      ));
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }
}