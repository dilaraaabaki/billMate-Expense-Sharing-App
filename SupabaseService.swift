//
//  SupabaseService.swift
//  billMate
//
//  Created by Dilara Baki on 24.08.2025.
//


import Foundation
import Combine

@MainActor
class SupabaseService: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isLoggedIn = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var currentUser: User?
    
    // MARK: - User Model
    struct User: Codable, Identifiable {
        let id: String
        let email: String
        let fullName: String
        let provider: String
        let createdAt: Date
        
        enum CodingKeys: String, CodingKey {
            case id
            case email
            case fullName = "full_name"
            case provider
            case createdAt = "created_at"
        }
    }
    
    // MARK: - Private Properties
    // TODO: Supabase client'ını burada initialize edin
    // private let supabase = SupabaseClient(supabaseURL: URL(string: "YOUR_SUPABASE_URL")!, supabaseKey: "YOUR_ANON_KEY")
    
    // MARK: - Public Methods
    func authenticateWithApple(data: [String: String]) {
        Task {
            do {
                print("🔄 Supabase authentication başlıyor...")
                
                // TODO: Gerçek Supabase authentication
                /*
                let response = try await supabase.auth.signInWithIdToken(
                    credentials: OpenIDConnectCredentials(
                        provider: .apple,
                        idToken: data["token"]!,
                        nonce: data["nonce"]!
                    )
                )
                
                // Kullanıcı bilgilerini al
                if let user = response.user {
                    await handleAuthSuccess(user: user, additionalData: data)
                }
                */
                
                // Şimdilik test implementasyonu
                try await simulateAuthentication(with: data)
                
            } catch {
                await handleAuthError(error)
            }
        }
    }
    
    func logout() async {
        do {
            print("🔄 Çıkış yapılıyor...")
            
            // TODO: Gerçek Supabase logout
            /*
            try await supabase.auth.signOut()
            */
            
            // Şimdilik test implementasyonu
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 saniye bekleme
            
            await MainActor.run {
                self.isLoggedIn = false
                self.currentUser = nil
                print("✅ Başarıyla çıkış yapıldı")
            }
            
        } catch {
            await MainActor.run {
                self.showErrorAlert("Çıkış yapılırken hata oluştu: \(error.localizedDescription)")
            }
        }
    }
    
    func checkAuthenticationStatus() async {
        // TODO: Supabase session kontrolü
        /*
        if let session = try? await supabase.auth.session {
            await handleExistingSession(session)
        }
        */
    }
    
    // MARK: - Private Methods
    private func simulateAuthentication(with data: [String: String]) async throws {
        // Simulated network delay
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 saniye
        
        // Simulated user creation
        let simulatedUser = User(
            id: data["user_id"] ?? UUID().uuidString,
            email: data["email"] ?? "test@example.com",
            fullName: data["full_name"] ?? "Test User",
            provider: "apple",
            createdAt: Date()
        )
        
        await MainActor.run {
            self.currentUser = simulatedUser
            self.isLoggedIn = true
            print("✅ Supabase authentication simüle edildi!")
            print("👤 Kullanıcı: \(simulatedUser.fullName)")
            print("📧 Email: \(simulatedUser.email)")
        }
    }
    
    private func handleAuthSuccess(userData: [String: Any]) async {
        // Kullanıcı verilerini işle ve kaydet
        await MainActor.run {
            self.isLoggedIn = true
            print("✅ Supabase authentication başarılı!")
        }
    }
    
    private func handleAuthError(_ error: Error) async {
        print("❌ Supabase authentication hatası: \(error.localizedDescription)")
        
        let errorMessage: String
        
        // Supabase error handling
        if error.localizedDescription.contains("Invalid") {
            errorMessage = "Geçersiz kimlik bilgileri"
        } else if error.localizedDescription.contains("Network") {
            errorMessage = "İnternet bağlantısı hatası"
        } else {
            errorMessage = "Sunucu hatası oluştu. Lütfen tekrar deneyin."
        }
        
        await MainActor.run {
            self.showErrorAlert(errorMessage)
        }
    }
    
    private func showErrorAlert(_ message: String) {
        alertMessage = message
        showAlert = true
    }
    
    // MARK: - User Preferences
    func saveUserPreferences() {
        // Kullanıcı tercihlerini kaydet
        if let user = currentUser {
            UserDefaults.standard.set(user.id, forKey: "current_user_id")
            UserDefaults.standard.set(user.email, forKey: "current_user_email")
        }
    }
    
    func clearUserPreferences() {
        UserDefaults.standard.removeObject(forKey: "current_user_id")
        UserDefaults.standard.removeObject(forKey: "current_user_email")
    }
}
