//
//  RestaurantInfoView.swift
//  LinguaLens
//
//  Created by Elif Buse Köprücü on 24.03.2025.
//

import SwiftUI

struct RestaurantInfoView: View {
    var restaurantName: String = "Örnek Restoran"
    var address: String = "İstanbul, Türkiye"
    var rating: Double = 4.5
    var reviews: [String] = [
        "Yemekler harikaydı!",
        "Servis hızlı ve nazikti.",
        "Tekrar geleceğim kesinlikle."
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text(restaurantName)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("📍 \(address)")
                    .foregroundColor(.secondary)

                Text("⭐️ Puan: \(String(format: "%.1f", rating))/5")
                    .font(.headline)

                Divider()

                Text("💬 Yorumlar")
                    .font(.title2)
                    .bold()

                ForEach(reviews, id: \.self) { review in
                    Text("• \(review)")
                        .padding(.bottom, 5)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Restoran Bilgileri")
    }
}

#Preview {
    RestaurantInfoView()
}



