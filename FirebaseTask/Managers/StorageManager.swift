//
//  StorageManager.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 8.10.2024.
//

import FirebaseStorage
import UIKit

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init () {}
    
    func saveImage(image : UIImage,completion : @escaping ((Bool) -> Void)) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("Media")
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            
            imageReference.putData(data) { metaData, error in
                if let error = error {
                    print("Storage Manager : \(error.localizedDescription)")
                }else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            FirestoreManager.shared.savePost(imageUrl: imageURL!) { comp in
                                DispatchQueue.main.async {
                                    if comp {
                                        completion(true)
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
}
