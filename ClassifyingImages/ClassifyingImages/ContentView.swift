//
//  ContentView.swift
//  ClassifyingImages
//
//  Created by Nathapong Masathien on 15/3/25.
//

import SwiftUI
import PhotosUI
import Vision
import CoreML

struct ContentView: View {
    
    @State private var image: UIImage?
    @State private var classificationLabel: String?
    @State private var selectedItem: PhotosPickerItem?
    @State private var showCameraPicker = false
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            
            Text(classificationLabel ?? "เลือกภาพเพื่อทำการจำแนกประเภท")
                .padding()
            
            HStack {
                PhotosPicker("เลือกภาพ", selection: $selectedItem)
                    .onChange(of: selectedItem) { oldValue, newValue in
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                image = uiImage
                                classifyImage()
                            }
                        }
                    }
                
                Button("ถ่ายภาพ") {
                    showCameraPicker = true
                }
            }
            .padding()
        }
        .padding()
        .sheet(isPresented: $showCameraPicker) {
            ImagePicker(image: $image, sourceType: .camera)
                            .ignoresSafeArea()
                            .onChange(of: image) { oldValue, newValue in
                                if newValue != nil {
                                    classifyImage()
                                }
                            }
        }
    }
    
    func classifyImage() {
        guard let image = image,
              let ciImage = CIImage(image: image) else { return }
        
        do {
            let configuration = MLModelConfiguration() // สร้าง configuration ขึ้นมาเพื่อใช้กำหนดค่าต่าง ๆ ของโมเดล เช่น การใช้ GPU หรือ CPU
            let model = try VNCoreMLModel(for: MobileNetV2(configuration: configuration).model) // สร้างโมเดลขึ้นมาจาก CoreML โดยใช้ MobileNetV2 ที่เราสร้างไว้
            let request = VNCoreMLRequest(model: model) { request, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let results = request.results as? [VNClassificationObservation],
                      let bestResult = results.first else { return }
                
                classificationLabel = "\(bestResult.identifier) \(bestResult.confidence * 100)%"
            }
            
            let handler = VNImageRequestHandler(ciImage: ciImage)
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    ContentView()
}
