class FirestoreDocumentWrite {
  const FirestoreDocumentWrite({
    required this.collection,
    required this.documentId,
    required this.data,
  });

  final String collection;
  final String documentId;
  final Map<String, Object?> data;
}
