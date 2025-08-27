import Foundation
import AuthenticationServices
import Supabase
import CryptoKit

@MainActor
class AuthenticationManager: NSObject, ObservableObject {
    // Published properties for UI binding
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    // Supabase client
    private let supabase: SupabaseClient
    
    // Current nonce for Apple Sign-In security
    private var currentNonce: String?
    
    override init() {
        // Initialize Supabase client
        self.supabase = SupabaseClient(
            supabaseURL: URL(string: "https://hxdawsweedvqxufuhzco.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4ZGF3c3dlZWR2cXh1ZnVoemNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxMzEyNTksImV4cCI6MjA3MTcwNzI1OX0.SrMzVQNn6QsHvW9h7zCJV7eFOQKCu2VTdbZzW_BK9Lk" 
        )
        super.init()
    }
    
    // MARK: - Public Methods
    
    func handleSignInRequest(_ request: ASAuthorizationAppleIDRequest) {
        isLoading = true
        
        // Generate nonce for security
        let nonce = randomNonceString()
        currentNonce = nonce
        
        // Configure the request
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }
    
    func handleSignInCompletion(_ result: Result<ASAuthorization, Error>) {
        Task {
            await processSignInResult(result)
        }
    }
    
    func checkAuthenticationStatus() async {
        do {
            // Check if user has valid session
            let session = try await supabase.auth.session
            // Check if session exists and is valid
            self.isLoggedIn = session.user != nil
        } catch {
            // No valid session found
            print("No valid session: \(error)")
            self.isLoggedIn = false
        }
    }
    
    func signOut() async {
        do {
            try await supabase.auth.signOut()
            self.isLoggedIn = false
        } catch {
            await self.showErrorAlert("Çıkış yapılamadı: \(error.localizedDescription)")
        }
    }
    
    func dismissAlert() {
        showAlert = false
        alertMessage = ""
    }
    
    // MARK: - Private Methods
    
    private func processSignInResult(_ result: Result<ASAuthorization, Error>) async {
        switch result {
        case .success(let authorization):
            await handleSuccessfulAuthorization(authorization)
        case .failure(let error):
            await handleAuthorizationError(error)
        }
    }
    
    private func handleSuccessfulAuthorization(_ authorization: ASAuthorization) async {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            await showErrorAlert("Geçersiz kimlik bilgisi")
            return
        }
        
        guard let identityToken = appleIDCredential.identityToken,
              let idTokenString = String(data: identityToken, encoding: .utf8) else {
            await showErrorAlert("Kimlik token'ı alınamadı")
            return
        }
        
        do {
            // Sign in to Supabase with Apple ID token
            try await supabase.auth.signInWithIdToken(
                credentials: .init(
                    provider: .apple,
                    idToken: idTokenString
                )
            )
            
            // Optional: Update user profile with Apple ID info
            await updateUserProfile(appleIDCredential)
            
            self.isLoggedIn = true
            self.isLoading = false
            
        } catch {
            await showErrorAlert("Giriş başarısız: \(error.localizedDescription)")
        }
    }
    
    private func handleAuthorizationError(_ error: Error) async {
        let errorCode = (error as NSError).code
        
        let message: String
        switch errorCode {
        case ASAuthorizationError.canceled.rawValue:
            message = "Giriş iptal edildi"
        case ASAuthorizationError.failed.rawValue:
            message = "Giriş başarısız oldu"
        case ASAuthorizationError.invalidResponse.rawValue:
            message = "Geçersiz yanıt"
        case ASAuthorizationError.notHandled.rawValue:
            message = "İşlem gerçekleştirilemedi"
        default:
            message = "Bilinmeyen hata: \(error.localizedDescription)"
        }
        
        await showErrorAlert(message)
    }
    
    private func updateUserProfile(_ credential: ASAuthorizationAppleIDCredential) async {
        // Optional: Update user metadata in Supabase
        var updates: [String: AnyJSON] = [:]
        
        if let fullName = credential.fullName {
            let displayName = [fullName.givenName, fullName.familyName]
                .compactMap { $0 }
                .joined(separator: " ")
            
            if !displayName.isEmpty {
                updates["display_name"] = AnyJSON.string(displayName)
            }
        }
        
        if let email = credential.email {
            updates["email"] = AnyJSON.string(email)
        }
        
        if !updates.isEmpty {
            do {
                try await supabase.auth.update(user: UserAttributes(data: updates))
                print("User profile updated successfully")
            } catch {
                print("Failed to update user profile: \(error)")
            }
        }
    }
    
    private func showErrorAlert(_ message: String) async {
        self.isLoading = false
        self.alertMessage = message
        self.showAlert = true
    }
    
    // MARK: - Security Helpers
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}

// MARK: - Supabase Extensions

extension AuthenticationManager {
    // Helper method to get current user
    func getCurrentUser() async throws -> User? {
        let session = try await supabase.auth.session
        return session.user
    }
    
    // Helper method to get current session
    func getCurrentSession() async throws -> Session? {
        return try await supabase.auth.session
    }
}
