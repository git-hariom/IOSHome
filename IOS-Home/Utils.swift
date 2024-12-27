//
//  Utils.swift
//  IOS-Home
//
//  Created by Hariom Sinha on 27/12/24.
//

import SwiftUI
import UIKit


struct FileManagerHelper {
    static let shared = FileManagerHelper()
    let imagesFolderName = "IOSHomeCaptures"
    
    init() {
           createFolderIfNeeded()
    }
    
    private func getFolderPath() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imagesFolderName)
    }
    
    func createFolderIfNeeded() {
           let folderPath = getFolderPath()
           if !FileManager.default.fileExists(atPath: folderPath.path) {
               do {
                   try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
               } catch {
                   print("Failed to create folder: \(error.localizedDescription)")
               }
           }
    }
    
    func saveImage(_ image: UIImage) -> URL? {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }

        let fileName = UUID().uuidString + ".jpg"
        let fileURL = getFolderPath().appendingPathComponent(fileName)

        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            print("Failed to save image: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchAllImages() -> [URL] {
        let folderPath = getFolderPath()

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderPath, includingPropertiesForKeys: nil)
            return fileURLs.filter { $0.pathExtension == "jpg" }
        } catch {
            print("Failed to fetch images: \(error.localizedDescription)")
            return []
        }
    }
}
