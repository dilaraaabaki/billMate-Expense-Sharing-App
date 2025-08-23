//
//  AuthenticationViewModel.s
//  billMate
//
//  Created by Dilara Baki on 23.08.2025.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Firebase Authentication veya başka bir auth servisi için fonksiyonlar
    func signIn(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        // Burada authentication işlemlerinizi implemente edin
        // Örnek: Firebase Auth, Apple Sign In, vs.
        
        // Simüle edilmiş giriş işlemi
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            if email.contains("@") && password.count >= 6 {
                self.isAuthenticated = true
            } else {
                self.errorMessage = "Geçersiz email veya şifre"
            }
        }
    }
    
    func signOut() {
        isAuthenticated = false
        // Çıkış işlemleri
    }
}
