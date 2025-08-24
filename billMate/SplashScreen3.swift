import SwiftUI
import AuthenticationServices

struct SplashScreen3: View {
    var body: some View {
        VStack(spacing: 32) {
            
            Text("Masrafları Adil Bir Şekilde Paylaşın!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.top, 40)
    
            Image("SplashImage3")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 230)
                .padding(.vertical, 16)
            
            Text("Ev arkadaşlarınızla masrafları paylaşın ve herkes ne kadar ödediğini görsün")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
            
            Spacer(minLength: 60)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .overlay(alignment: .bottom) {
            SignInWithAppleButton(.signIn) { request in
            } onCompletion: { result in
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .cornerRadius(25)
            .padding(.horizontal, 24)
            .padding(.bottom, 44)
        }
    }
}

#Preview {
    SplashScreen3()
}
