//
//  ContentViewIntentHandler.swift
//  Veggy
//
//  Created by Derrick Ding on 5/26/23.
//

import Foundation

class ContentViewIntentHandler {
    func setVeggyUserData() {
        if !FileHandler.FileInDocumentDirectory(file: "UserInfo.json") {
            FileHandler.CopyFileFromBundleToDocumentsFolder(sourceFile: "UserInfo.json")
        }
    }
    
    func resetVeggyUserData() {
        let json = FileHandler.GetJSONDataFromFile(fileName: "UserInfo.json")
        
        if var json = json {
            json["name"] = ""
            json["age"] = 0
        }
    }
    
    func getUser() -> String {
        let json = FileHandler.GetJSONDataFromFile(fileName: "UserInfo.json")
        
        if let json = json {
            return json["name"].stringValue
        }
        
        return ""
    }
}
