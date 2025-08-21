// SplashScreen3.swift

import SwiftUI
import AuthenticationServices 

struct SplashScreen3: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
                    .frame(height: 48)
            
            Text("Masrafları Adil Bir Şekilde Paylaşın !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)
    
            Image("SplashImage3")
                .resizable()
                .scaledToFit()
                .frame(width: 329, height: 249)
                .padding(.top, 30)
            
            Text("Ev arkadaşlarınızla masrafları paylaşın ve herkes ne kadar ödediğini görsün")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .overlay(alignment: .bottom) {
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    
                    case .success(_):
                        print("Apple ile giriş başarılı!")
                        
                    case .failure(let error):
                        print("Hata: \(error.localizedDescription)")
                    }
                }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(height: 55)
            .cornerRadius(10)
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
        
    }
}

#Preview {
    SplashScreen3()
}
