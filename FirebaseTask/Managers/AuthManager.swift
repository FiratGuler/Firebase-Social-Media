//
//  AuthManager.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Register
    
    public func registerNewUser(email : String , password : String, completion : @escaping (Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error  in
           
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            }else {
               completion(true)
            }
        }
    }
    
    public func verificationEmail(completion : @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("verification func : Kullanıcı bulunamadı")
            completion(false)
            return
        }
        
        user.sendEmailVerification { error in
            if let error = error {
                print("Doğrulama e-postası gönderilemedi: \(error.localizedDescription)")
                completion(false)
                return
            }
            print("Doğrulama e-postası gönderildi.")
            completion(true)
        }
    }
    
    // MARK: - Login
    
    public func logInUser(email : String , password : String , completion : @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false)
                print(error.localizedDescription)
            }else {
                completion(true)
            }
        }
    }
    
    public func logOut() {
        do {
            try Auth.auth().signOut()
        }catch {
            print(error.localizedDescription)
        }
   
    }
    
    public func resetPassword(email : String , completion : @escaping (String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(error.localizedDescription)
            }else {
                completion("Password reset email sent.")
            }
        }
    }
    
}
