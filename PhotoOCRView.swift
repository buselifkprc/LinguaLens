//
//  PhotoOCRView.swift
//  LinguaLens
//
//  Created by Elif Buse Köprücü on 24.03.2025.
//

import SwiftUI
import PhotosUI
import Vision

struct PhotoOCRView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var recognizedText: String = ""
    @State private var navigateToTranslation = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("LinguaLens")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(15)
                        .padding()
                        .shadow(radius: 5)
                }

                if !recognizedText.isEmpty {
                    Text("Tanınan Metin:")
                        .font(.headline)
                        .padding(.top)

                    ScrollView {
                        Text(recognizedText)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }

                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Label("Fotoğraf Yükle", systemImage: "photo")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Geçiş
                NavigationLink(destination: TranslateView(textToTranslate: recognizedText), isActive: $navigateToTranslation) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = uiImage
                        recognizeTextFromImage(uiImage)
                    }
                }
            }
            .navigationTitle("OCR Sayfası")
        }
    }

    func recognizeTextFromImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            if let observations = request.results as? [VNRecognizedTextObservation] {
                let text = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
                DispatchQueue.main.async {
                    recognizedText = text
                    navigateToTranslation = true
                }
            }
        }

        request.recognitionLevel = .accurate

        do {
            try requestHandler.perform([request])
        } catch {
            print("OCR hatası: \(error.localizedDescription)")
        }
    }
}
