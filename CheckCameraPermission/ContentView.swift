//
//  ContentView.swift
//  CheckCameraPermission
//
//  Created by 米国梁 on 2021/5/1.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State var title = ""
    
    @State var message = ""
    
    var body: some View {
        VStack {
            
            if title != "" {
                Text(title)
                Text(message)
            }
            
            Button("Check camera permission") {
                
                let status = AVCaptureDevice.authorizationStatus(for: .video)
                switch status {
                case .authorized:
                    title = "Authorized"
                    message = "You can use camera"
                case .notDetermined:
                    AVCaptureDevice.requestAccess(for: .video) { granted in
                        if granted {
                            title = "Authorized"
                            message = "User allows app to access camera"
                        }
                    }
                case .denied:
                    title = "Denied"
                    message = "User rejected app to access camera"
                case .restricted:
                    title = "Restricted"
                    message = "User is limited by Parent settings to access camera"
                @unknown default:
                    fatalError("Unknown status: \(status.rawValue)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
