class CloudStorageException implements Exception {
  const CloudStorageException();
}

//C in CRUD
class CouldNotCreateException extends CloudStorageException {}

//R in CRUD
class CouldNotGetAllNotesException extends CloudStorageException {}

//U in CRUD
class CouldNotUpdateNoteException extends CloudStorageException {}

//D in CRUD
class CouldNotDeleteNoteException extends CloudStorageException {}
