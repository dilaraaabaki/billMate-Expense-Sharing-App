import Supabase
import Foundation

class AuthenticationManager: ObservableObject {
    static let shared = AuthenticationManager()
    private let client = SupabaseManager.shared.client
    
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    init() {
        checkCurrentUser()
    }
    
    func checkCurrentUser() {
        if let user = client.auth.currentUser {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
    // Apple Sign-In ile giriş
    func signInWithApple(idToken: String, nonce: String) async throws -> Session {
        return try await client.auth.signInWithIdToken(
            credentials: .init(
                provider: .apple,
                idToken: idToken,
                nonce: nonce
            )
        )
    }
    
    // Email ile giriş
    func signInWithEmail(email: String, password: String) async throws -> Session {
        return try await client.auth.signIn(
            email: email,
            password: password
        )
    }
    
    // Kayıt ol
    func signUp(email: String, password: String) async throws -> AuthResponse {
        return try await client.auth.signUp(
            email: email,
            password: password
        )
    }
    
    // Çıkış yap
    func signOut() async throws {
        try await client.auth.signOut()
        DispatchQueue.main.async {
            self.currentUser = nil
            self.isAuthenticated = false
        }
    }
    
    // Şifre sıfırlama
    func resetPassword(email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
    }
}
