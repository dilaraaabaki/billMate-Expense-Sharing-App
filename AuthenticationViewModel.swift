// AuthenticationViewModel.swift

import Foundation
import Firebase // Genel Firebase işlemleri için
import FirebaseAuth // BU EN ÖNEMLİSİ! Hatanın çözümü için bu satır şart.
import AuthenticationServices
import CryptoKit

// 2. SINIF TANIMLAMASI: Kodun bir sınıf olduğunu belirtir.
class AuthenticationViewModel: ObservableObject {
    
    // @Published: Bu değişken her değiştiğinde, onu dinleyen SwiftUI View'ları otomatik olarak güncellenir.
    @Published var userSession: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Apple'a gönderilen "nonce"ı geçici olarak saklamak için. Bu bir güvenlik önlemidir.
    private var currentNonce: String?
    
    init() {
        // ViewModel ilk oluşturulduğunda, Firebase'de mevcut bir kullanıcı oturumu var mı diye kontrol et.
        self.userSession = Auth.auth().currentUser
    }
    
    // --- APPLE İLE GİRİŞ FONKSİYONLARI ---
    
    /// Apple'dan gelen kimlik bilgilerini alıp Firebase'e göndererek giriş işlemini tamamlar.
    @MainActor
    func signInWithApple(credentials: ASAuthorizationAppleIDCredential, completion: @escaping (Error?) -> Void) {
        // DÜZELTME: fatalError yerine güvenli hata yönetimi
        guard let nonce = currentNonce else {
            let error = NSError(domain: "AuthError", code: -100, userInfo: [NSLocalizedDescriptionKey: "Nonce bulunamadı. Lütfen tekrar deneyin."])
            print("Hata: Nonce bulunamadı. Bu bir güvenlik problemi olabilir.")
            DispatchQueue.main.async {
                self.errorMessage = "Güvenlik hatası. Lütfen tekrar deneyin."
            }
            completion(error)
            return
        }
        
        guard let appleIDToken = credentials.identityToken else {
            let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Apple ID Token bulunamadı."])
            print("Hata: Apple ID Token bulunamadı.")
            DispatchQueue.main.async {
                self.errorMessage = "Apple kimlik doğrulama hatası."
            }
            completion(error)
            return
        }
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            let error = NSError(domain: "AuthError", code: -2, userInfo: [NSLocalizedDescriptionKey: "ID Token işlenemedi."])
            print("Hata: ID Token işlenemedi.")
            DispatchQueue.main.async {
                self.errorMessage = "Kimlik doğrulama verisi işlenemedi."
            }
            completion(error)
            return
        }
        
        // Loading durumunu başlat
        isLoading = true
        errorMessage = nil
        
        // Firebase'in anlayacağı formatta bir kimlik bilgisi oluşturuyoruz.
        let firebaseCredential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: credentials.fullName
        )
        
        // Firebase ile giriş yapıyoruz.
        Auth.auth().signIn(with: firebaseCredential) { [weak self] (authResult, error) in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("Firebase ile Apple girişi başarısız: \(error.localizedDescription)")
                    self?.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
                    completion(error)
                    return
                }
                
                // Başarılı! userSession'ı güncelleyerek UI'ın değişmesini tetikliyoruz.
                self?.userSession = authResult?.user
                self?.errorMessage = nil
                print("Firebase'e Apple ile başarıyla giriş yapıldı.")
                completion(nil)
            }
        }
    }
    
    /// Her giriş denemesi için benzersiz ve güvenli bir dize (nonce) oluşturur.
    func generateNonce() -> String {
        let rawNonce = UUID().uuidString
        self.currentNonce = rawNonce
        
        let inputData = Data(rawNonce.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashString
    }
    
    /// Nonce'u temizler (güvenlik için)
    func clearNonce() {
        self.currentNonce = nil
    }
    
    /// Hata mesajını temizler
    func clearError() {
        self.errorMessage = nil
    }

    /// Kullanıcının oturumunu kapatır.
    func signOut() {
        isLoading = true
        errorMessage = nil
        
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.clearNonce() // Güvenlik için nonce'u temizle
            print("Başarıyla çıkış yapıldı.")
        } catch let error {
            print("Çıkış yaparken hata oluştu: \(error.localizedDescription)")
            self.errorMessage = "Çıkış yaparken hata oluştu: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Kullanıcının giriş durumunu kontrol eder
    func checkAuthState() {
        self.userSession = Auth.auth().currentUser
    }
} // <-- 3. SINIFIN BİTİŞİ: Bu parantez de çok önemli.
