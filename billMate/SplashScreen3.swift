import SwiftUI
import AuthenticationServices

struct SplashScreen3: View {
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false
    
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
            VStack(spacing: 16) {
                // Loading indicator
                if isLoading {
                    HStack {
                        ProgressView()
                            .scaleEffect(0.8)
                        Text("Giriş yapılıyor...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 8)
                }
                
                // Apple Sign-In Button (UI only - no functionality)
                SignInWithAppleButton(.signIn) { request in
                    // Placeholder for sign-in request
                    isLoading = true
                } onCompletion: { result in
                    // Placeholder for completion handler
                    isLoading = false
                }
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .cornerRadius(25)
                .disabled(isLoading)
                .opacity(isLoading ? 0.6 : 1.0)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 44)
        }
        .alert("Giriş Durumu", isPresented: $showAlert) {
            Button("Tamam", role: .cancel) {
                showAlert = false
            }
        } message: {
            Text(alertMessage)
        }
        .fullScreenCover(isPresented: $isLoggedIn) {
            // Placeholder for home page
            Text("Ana Sayfa")
                .font(.title)
        }
    }
}

#Preview {
    SplashScreen3()
}
