//
//  AppleSignInService.swift
//  billMate
//
//  Created by Dilara Baki on 24.08.2025.
//

import Foundation
import AuthenticationServices
import CryptoKit
import Combine

@MainActor
class AppleSignInService: ObservableObject {
    
    // MARK: - Published Properties
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false
    
    // MARK: - Private Properties
    private var currentNonce: String?
    
    // MARK: - Public Methods
    func configureRequest(_ request: ASAuthorizationAppleIDRequest) {
        isLoading = true
        
        // İstenen kapsamları ayarla
        request.requestedScopes = [.fullName, .email]
        
        // Güvenlik için nonce oluştur
        let nonce = generateRandomNonce()
        currentNonce = nonce
        request.nonce = sha256(nonce)
        
        // Debug için
        print("Apple Sign-In isteği yapılandırıldı")
    }
    
    func handleCompletion(
        _ result: Result<ASAuthorization, Error>,
        onSuccess: @escaping ([String: String]) -> Void
    ) {
        isLoading = false
        
        switch result {
        case .success(let authorization):
            handleSuccess(authorization: authorization, onSuccess: onSuccess)
        case .failure(let error):
            handleError(error) // FIXED: Removed the extraneous 'error:' label
        }
    }
    
    // MARK: - Private Methods
    private func handleSuccess(
        authorization: ASAuthorization,
        onSuccess: @escaping ([String: String]) -> Void
    ) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            showErrorAlert("Apple kimlik doğrulama hatası")
            return
        }
        
        // Apple'dan gelen bilgileri al
        let userID = appleIDCredential.user
        let email = appleIDCredential.email
        let fullName = appleIDCredential.fullName
        let identityToken = appleIDCredential.identityToken
        let authorizationCode = appleIDCredential.authorizationCode
        
        // Token ve nonce doğrula
        guard let nonce = currentNonce,
              let identityTokenString = identityToken.flatMap({ String(data: $0, encoding: .utf8) }),
              let authCodeString = authorizationCode.flatMap({ String(data: $0, encoding: .utf8) }) else {
            showErrorAlert("Apple Sign-In verilerinde hata oluştu")
            return
        }
        
        // Supabase için veri hazırla
        let appleSignInData = [
            "provider": "apple",
            "token": identityTokenString,
            "nonce": nonce,
            "user_id": userID,
            "email": email ?? "",
            "full_name": formatFullName(fullName),
            "authorization_code": authCodeString
        ]
        
        // Debug bilgileri
        print("🍎 Apple Sign-In Başarılı!")
        print("📧 Email: \(email ?? "Belirtilmedi")")
        print("👤 Full Name: \(formatFullName(fullName))")
        print("🆔 User ID: \(userID)")
        
        // Başarı callback'ini çağır
        onSuccess(appleSignInData)
        
        // Nonce'u temizle
        currentNonce = nil
    }
    
    private func handleError(_ error: Error) {
        print("❌ Apple Sign-In Hatası: \(error.localizedDescription)")
        
        var errorMessage = "Giriş hatası oluştu"
        
        if let authError = error as? ASAuthorizationError {
            switch authError.code {
            case .canceled:
                // Kullanıcı iptal etti, alert gösterme
                return
            case .failed:
                errorMessage = "Apple ile giriş başarısız oldu"
            case .invalidResponse:
                errorMessage = "Apple'dan geçersiz yanıt alındı"
            case .notHandled:
                errorMessage = "Giriş işlemi gerçekleştirilemedi"
            case .unknown:
                errorMessage = "Bilinmeyen hata oluştu"
            @unknown default:
                errorMessage = "Beklenmeyen bir hata oluştu"
            }
        } else {
            errorMessage = "Bağlantı hatası: \(error.localizedDescription)"
        }
        
        showErrorAlert(errorMessage)
    }
    
    private func formatFullName(_ fullName: PersonNameComponents?) -> String {
        let firstName = fullName?.givenName ?? ""
        let lastName = fullName?.familyName ?? ""
        return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
    
    private func showErrorAlert(_ message: String) {
        alertMessage = message
        showAlert = true
    }
    
    // MARK: - Security Helper Methods
    private func generateRandomNonce(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Güvenli nonce oluşturulamadı. SecRandomCopyBytes hatası: \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 { return }
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
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}
