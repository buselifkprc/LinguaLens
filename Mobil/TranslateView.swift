//
//  TranslateView.swift
//  LinguaLens
//
//  Created by Elif Buse Köprücü on 24.03.2025.
//

import SwiftUI

struct TranslateView: View {
    var textToTranslate: String
    @State private var translatedText: String = ""
    @State private var navigateToRestaurantInfo = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("🔤 Orijinal Metin")
                .font(.headline)

            ScrollView {
                Text(textToTranslate)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }

            Text("🌍 Çeviri")
                .font(.headline)

            ScrollView {
                Text(translatedText)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
            }

            Spacer()

            Button("Restoran Bilgilerini Gör") {
                navigateToRestaurantInfo = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            NavigationLink(destination: RestaurantInfoView(), isActive: $navigateToRestaurantInfo) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
        .navigationTitle("Çeviri")
        .onAppear {
            // Geçici çeviri simülasyonu
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                translatedText = "Bu çeviri örneğidir. (Simüle edilmiş)"
            }
        }
    }
}

#Preview {
    TranslateView(textToTranslate: "Örnek metin")
}

         
