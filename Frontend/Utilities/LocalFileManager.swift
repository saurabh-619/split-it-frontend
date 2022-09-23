//
//  LocalFileManager.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/09/22.
//

import Foundation
import SwiftUI


class LocalFileManager {
    static let shared = LocalFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folder: String) {
        // create local cache folder
        createCacheFolder(name: folder)
        
        // create image data and image local url
        guard let data = image.pngData(),
              let url = getImageUrl(name: imageName, folder: folder)
        else { return }
        
        // save image locally
        do {
            try data.write(to: url)
        } catch let error {
            print("error in saving image \(imageName) - \(error.localizedDescription)")
        }
    }
    
    func createCacheFolder(name: String) {
        // get folder url
        guard let url = getFolderUrl(name: name) else { return }
        
        // create if doesn't exists
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("error in creating foler \(name). \(error.localizedDescription)")
            }
        }
        
    }
    
    func getFolderUrl(name: String) -> URL? {
        // get cache dir url
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        return url.appendingPathComponent(name)
    }
    
    func getImageUrl(name: String, folder: String) -> URL? {
        guard let folderUrl = getFolderUrl(name: folder) else { return nil }
        return folderUrl.appendingPathComponent(name + ".png")
    }
}
