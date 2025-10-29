// TODO: Générer ce fichier avec 'flutterfire configure'
// Ce fichier sera créé automatiquement lors de la configuration Firebase

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnimplementedError(
      'Veuillez exécuter "flutterfire configure" pour générer ce fichier',
    );
  }
}

class FirebaseOptions {
  const FirebaseOptions({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
  });

  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
}
