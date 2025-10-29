// lib/data/datasources/remote/auth_firebase_datasource.dart
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soloesport/core/errors/failures.dart';
import 'package:soloesport/data/models/user_model.dart';

abstract class AuthFirebaseDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserModel user, String password);
  Future<UserModel> getCurrentUser();
  Future<bool> logout();
  Future<UserModel> updateUserProfile(UserModel user);
  Future<bool> resetPassword(String email);
}

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthFirebaseDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      // Authentification avec Firebase Auth
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AuthException('Utilisateur non trouvé');
      }

      // Récupération des données utilisateur depuis Firestore
      final userDoc = await firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw AuthException('Données utilisateur non trouvées');
      }

      // Mise à jour de la dernière connexion
      await firestore.collection('users').doc(credential.user!.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      return UserModel.fromJson({
        ...userDoc.data()!,
        'id': credential.user!.uid,
      });
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register(UserModel user, String password) async {
    try {
      // Création du compte Firebase Auth
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      if (credential.user == null) {
        throw AuthException('Échec de la création du compte');
      }

      // Mise à jour du profil Firebase
      await credential.user!.updateDisplayName(user.name);

      // Création du document utilisateur dans Firestore
      final userData = {
        'name': user.name,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'profileImageUrl': user.profileImageUrl,
        'isAdmin': false,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      };

      await firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userData);

      // Récupération du document créé
      final userDoc = await firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      return UserModel.fromJson({
        ...userDoc.data()!,
        'id': credential.user!.uid,
      });
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e.code));
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
        throw AuthException('Données utilisateur non trouvées');
      }

      return UserModel.fromJson({
        ...userDoc.data()!,
        'id': currentUser.uid,
      });
    } catch (e) {
      throw CacheException();
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

  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      
      if (currentUser == null) {
        throw AuthException('Aucun utilisateur connecté');
      }

      // Mise à jour du profil Firebase
      await currentUser.updateDisplayName(user.name);
      if (user.profileImageUrl != null) {
        await currentUser.updatePhotoURL(user.profileImageUrl);
      }

      // Mise à jour du document Firestore
      final updateData = {
        'name': user.name,
        'phoneNumber': user.phoneNumber,
        'profileImageUrl': user.profileImageUrl,
      };

      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(updateData);

      // Récupération du document mis à jour
      final userDoc = await firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      return UserModel.fromJson({
        ...userDoc.data()!,
        'id': currentUser.uid,
      });
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e.code));
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
      throw ValidationException(_getFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      throw ServerException();
    }
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Aucun utilisateur trouvé avec cet email';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'email-already-in-use':
        return 'Un compte existe déjà avec cet email';
      case 'invalid-email':
        return 'Email invalide';
      case 'weak-password':
        return 'Le mot de passe doit contenir au moins 6 caractères';
      case 'operation-not-allowed':
        return 'Opération non autorisée';
      case 'user-disabled':
        return 'Ce compte a été désactivé';
      default:
        return 'Une erreur s\'est produite. Veuillez réessayer';
    }
  }
}
