//
//  ContentView.swift
//  IOS-Home
//
//  Created by Hariom Sinha on 24/12/24.
//

import SwiftUI

// The data model or item you want to pass to the next page
struct Item {
    var title: String
}

struct LaunchView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                // background Layer
                Color.black
                
                
                //foreground Layer
                VStack{
                    Text("Castiel")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                                    
                    Text("Powered By CoreML")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    // define the test data to pass to the next page
                    let item = Item(title: "")
                    
                    // Button to navigate to next page
                    NavigationLink(destination: EnableCameraView(item: item)) {
                        Text("Take Pictures")
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
