class FirestoreDocumentPath {
  const FirestoreDocumentPath({
    required this.collection,
    required this.documentId,
  });

  final String collection;
  final String documentId;
}
