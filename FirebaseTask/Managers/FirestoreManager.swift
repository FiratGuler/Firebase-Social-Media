//
//  FirestoreManager.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 8.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    
    public func savePost(imageUrl: String , completion : @escaping ((Bool) -> Void)) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: currentDate)
        
        let firestoreDatabase = Firestore.firestore()
        var firestoreReference: DocumentReference? = nil
        let user = Auth.auth().currentUser?.email ?? "Unknown User"
        let uuid = UUID().uuidString
        

        let post = PostModel(postId: uuid, comments: [], date: dateString, image: imageUrl, postedBy: user)
        
        firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: post.toDictionary()) { error in
            if let error = error {
                print("Firestore Manager : \(error.localizedDescription)")
            } else {
                guard let documentId = firestoreReference?.documentID else { return }
        
                firestoreReference?.updateData(["postId": documentId]) { error in
                    if let error = error {
                        print("Post ID güncellenirken hata: \(error.localizedDescription)")
                    } else {
                        print("Post ID başarıyla güncellendi: \(documentId)")
                        completion(true)
                    }
                }
            }
        }
    }

    
    public func fetchFlowData(completion: @escaping (Result<[PostModel], Error>) -> Void) {
        let firestore = Firestore.firestore()
        let path = firestore.collection("Posts").order(by: "date", descending: true)
        
        path.addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            let datas = documents.compactMap { (snapshot) -> PostModel? in
                do {
                    let data = try snapshot.data(as: PostModel.self)
                    return data
                } catch {
                    print("Parse error: \(error.localizedDescription)")
                    completion(.failure(error))
                    return nil
                }
            }
            completion(.success(datas))
        }
    }
    
    public func addComment(postId: String, commentText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let firestoreDatabase = Firestore.firestore()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: currentDate)
        
        let user = Auth.auth().currentUser?.email ?? "gelmedi"
        
        let newComment = Comment(comment: commentText, date: dateString, postedBy: user)
        
        let postReference = firestoreDatabase.collection("Posts").document(postId)
        
        postReference.getDocument { (document, error) in
            if let document = document, document.exists {
              
                var commentsArray = document.data()?["comments"] as? [[String: Any]] ?? []
                
                commentsArray.append(newComment.toDictionary())
                
               
                postReference.updateData(["comments": commentsArray]) { error in
                    if let error = error {
                        print("Yorum güncellenirken hata: \(error.localizedDescription)")
                        completion(.failure(error))
                    } else {
                        print("Yorum başarıyla eklendi ve comments güncellendi.")
                        completion(.success(()))
                    }
                }
            } else {
                print("Post bulunamadı.")
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Post not found"])))
            }
        }
    }

}


