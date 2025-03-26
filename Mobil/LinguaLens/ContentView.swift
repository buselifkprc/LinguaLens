//
//  ContentView.swift
//  LinguaLens
//
//  Created by Elif Buse Köprücü on 23.03.2025.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isNewUser = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("LinguaLens")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("E-posta", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            SecureField("Şifre", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            Button(action: {
                handleAuth()
            }) {
                Text(isNewUser ? "Kayıt Ol" : "Giriş Yap")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Button(action: {
                // Google ile giriş ileride eklenecek
            }) {
                HStack {
                    Image(systemName: "globe")
                    Text("Google ile Giriş Yap")
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
            }

            Button(action: {
                isNewUser.toggle()
            }) {
                Text(isNewUser ? "Zaten üye misiniz? Giriş yapın" : "Yeni misiniz? Kayıt olun")
                    .foregroundColor(.blue)
                    .font(.footnote)
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .padding()
    }

    func handleAuth() {
        if isNewUser {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    errorMessage = "Kayıt hatası: \(error.localizedDescription)"
                } else {
                    errorMessage = "Kayıt başarılı!"
                }
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    errorMessage = "Giriş hatası: \(error.localizedDescription)"
                } else {
                    errorMessage = "Giriş başarılı!"
                }
            }
        }
    }
}
