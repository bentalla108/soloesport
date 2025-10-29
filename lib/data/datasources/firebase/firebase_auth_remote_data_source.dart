// lib/data/datasources/remote/firebase_auth_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:soloesport/core/errors/exceptions.dart';
import '../../models/user_model.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserModel user, String password);
  Future<UserModel> getCurrentUser();
  Future<UserModel> updateUserProfile(UserModel user);
  Future<bool> resetPassword(String email);
  Future<bool> logout();
}

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseAuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw AuthException('Échec de la connexion');
      }

      // Récupérer les données utilisateur depuis Firestore
      final userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw AuthException('Utilisateur introuvable');
      }

      // Mettre à jour la date de dernière connexion
      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({'last_login': FieldValue.serverTimestamp()});

      final userData = userDoc.data()!;
      userData['id'] = userDoc.id;
      
      return UserModel.fromJson(userData);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register(UserModel user, String password) async {
    try {
      // Créer l'utilisateur dans Firebase Auth
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      if (userCredential.user == null) {
        throw AuthException('Échec de l\'inscription');
      }

      // Créer le document utilisateur dans Firestore
      final userData = {
        'name': user.name,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'profile_image_url': user.profileImageUrl,
        'is_admin': false,
        'created_at': FieldValue.serverTimestamp(),
        'last_login': FieldValue.serverTimestamp(),
      };

      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userData);

      // Récupérer les données créées
      final userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      final createdUserData = userDoc.data()!;
      createdUserData['id'] = userDoc.id;

      return UserModel.fromJson(createdUserData);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser == null) {
        throw AuthException('Aucun utilisateur connecté');
      }

      final userDoc = await firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        throw AuthException('Utilisateur introuvable');
      }

      final userData = userDoc.data()!;
      userData['id'] = userDoc.id;

      return UserModel.fromJson(userData);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser == null) {
        throw AuthException('Aucun utilisateur connecté');
      }

      final updateData = {
        'name': user.name,
        'phone_number': user.phoneNumber,
        'profile_image_url': user.profileImageUrl,
      };

      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(updateData);

      return getCurrentUser();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  // Helper pour gérer les exceptions Firebase Auth
  AuthException _handleAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException('Aucun utilisateur trouvé avec cet email');
      case 'wrong-password':
        return AuthException('Mot de passe incorrect');
      case 'email-already-in-use':
        return AuthException('Cet email est déjà utilisé');
      case 'invalid-email':
        return AuthException('Email invalide');
      case 'weak-password':
        return AuthException('Le mot de passe est trop faible');
      case 'user-disabled':
        return AuthException('Ce compte a été désactivé');
      default:
        return AuthException('Erreur d\'authentification: ${e.message}');
    }
  }
}
