//
//  RemoteConfigManager.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 11.10.2024.
//

import Foundation
import FirebaseRemoteConfig


class RemoteConfigManager {
    
    enum RemoteConfigKeys: String {
        case title = "title"
        case titleIsHidden = "titleIsHidden"
        case year = "year"
    }
    
    enum RemoteConfigError: Error {
        case fetchFailed(String)
        case activationFailed(String)
        case invalidData(String)
    }
    
    static let shared = RemoteConfigManager()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    private init() {
        setupRemoteConfig()
    }
    
    private func setupRemoteConfig() {
        let defaultValues: [String: NSObject] = [
            RemoteConfigKeys.title.rawValue: "Merhaba Firebase!" as NSString,
            RemoteConfigKeys.titleIsHidden.rawValue: false as NSNumber,
            RemoteConfigKeys.year.rawValue: 10 as NSNumber
        ]
        remoteConfig.setDefaults(defaultValues)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600
        remoteConfig.configSettings = settings
    }
    
    func fetchRemoteConfig(completion: @escaping (Result<Void, RemoteConfigError>) -> Void) {
        remoteConfig.fetch { [weak self] status, error in
            if let error = error {
                completion(.failure(.fetchFailed(error.localizedDescription)))
                return
            }

            self?.remoteConfig.activate { changed, error in
                if let error = error {
                    completion(.failure(.activationFailed(error.localizedDescription)))
                    return
                }
                completion(.success(()))
            }
        }
    }
    
    func getTitle() -> String {
        let title = remoteConfig[RemoteConfigKeys.title.rawValue].stringValue
          
          return title
    }
    
    func getIsTitleHidden() -> Bool {
        return remoteConfig[RemoteConfigKeys.titleIsHidden.rawValue].boolValue
    }
    
    func getYear() -> Int {
        return remoteConfig[RemoteConfigKeys.year.rawValue].numberValue.intValue
    }
}
