//
//  EnableCamera.swift
//  IOS-Home
//
//  Created by Hariom Sinha on 24/12/24.
//

import SwiftUI

struct EnableCameraView: View {
    var item: Item
    @State private var isShowingCamera = false
    @State private var capturedImage: UIImage?
    @State private var savedImages: [URL] = []
    
    var body: some View {
        NavigationStack{
                //foreground Layer
                VStack{
                    NavigationLink(destination: LaunchView()) {
                        Text("Go To Launch Page")
                            .padding(10)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .border(Color.black)
                .background(Color.black)
                .cornerRadius(10)
                .padding(10)

                VStack {
                    // Display saved images
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(savedImages, id: \.self) { imageUrl in
                                if let uiImage = UIImage(contentsOfFile: imageUrl.path) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .cornerRadius(8)
                                        .shadow(radius: 5)
                                }
                            }
                        }
                    }
                    .padding()

                    // Button to open the camera
                    Button(action: {
                        isShowingCamera = true
                    }) {
                        Text("Open Camera")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    .sheet(isPresented: $isShowingCamera) {
                        ImagePicker(capturedImage: $capturedImage)
                            .onDisappear {
                                if let image = capturedImage {
                                    saveImage(image)
                                }
                            }
                    }
                }
                .navigationTitle("Camera & Gallery")
                .onAppear {
                    loadSavedImages()
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .border(Color.black)
                .background(Color.black)
                .cornerRadius(10)
                .padding(10)
        }
        .frame(maxHeight: .infinity)
    }
    
    func saveImage(_ image: UIImage) {
        if let savedURL = FileManagerHelper.shared.saveImage(image) {
            savedImages.append(savedURL)
        }
    }
    
    func loadSavedImages() {
        savedImages = FileManagerHelper.shared.fetchAllImages()
    }
}
