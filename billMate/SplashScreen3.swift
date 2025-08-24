import SwiftUI
import AuthenticationServices

struct SplashScreen3: View {
    @StateObject private var authManager = AuthenticationManager()
    
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
                if authManager.isLoading {
                    HStack {
                        ProgressView()
                            .scaleEffect(0.8)
                        Text("Giriş yapılıyor...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 8)
                }
                
                // Apple Sign-In Button
                SignInWithAppleButton(.signIn) { request in
                    authManager.handleSignInRequest(request)
                } onCompletion: { result in
                    authManager.handleSignInCompletion(result)
                }
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .cornerRadius(25)
                .disabled(authManager.isLoading)
                .opacity(authManager.isLoading ? 0.6 : 1.0)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 44)
        }
        .alert("Giriş Durumu", isPresented: $authManager.showAlert) {
            Button("Tamam", role: .cancel) {
                authManager.dismissAlert()
            }
        } message: {
            Text(authManager.alertMessage)
        }
        .fullScreenCover(isPresented: $authManager.isLoggedIn) {
            // HomePage view instead of the temporary success screen
            ContentView() // Replace with your actual home page
        }
        .onAppear {
            // Uygulama açılışında auth durumunu kontrol et
            Task {
                await authManager.checkAuthenticationStatus() // FIXED: Use the public method instead of direct access
            }
        }
    }
}

#Preview {
    SplashScreen3()
}
