import SwiftUI

struct CreateNewPasswordView: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Main content
            VStack(spacing: 40) {
                // Title and description
                VStack(spacing: 16) {
                    Text("Yeni şifre oluştur")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Yeni şifreniz daha önce kullandığınız şifrelerden benzersiz olmalıdır.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                
                // Password input fields
                VStack(spacing: 16) {
                    // New password field
                    SecureField("Yeni Şifre", text: $newPassword)
                        .font(.system(size: 16))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        )
                    
                    // Confirm password field
                    SecureField("Şifreyi Doğrula", text: $confirmPassword)
                        .font(.system(size: 16))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        )
                }
                .padding(.horizontal, 20)
                
                // Reset password button
                Button(action: {
                    // Reset password action
                    if validatePasswords() {
                        // Proceed with password reset
                        print("Password reset successful")
                    }
                }) {
                    Text("Şifreyi Sıfırla")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            RoundedRectangle(cornerRadius: 26)
                                .fill(Color.yellow.opacity(0.7))
                        )
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
            Spacer()
            
            // Home indicator
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.black)
                .frame(width: 134, height: 5)
                .padding(.bottom, 20)
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea()
    }
    
    private func validatePasswords() -> Bool {
        // Add password validation logic here
        guard !newPassword.isEmpty && !confirmPassword.isEmpty else {
            return false
        }
        
        guard newPassword == confirmPassword else {
            return false
        }
        
        // Add additional password strength validation if needed
        return true
    }
}

struct CreateNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPasswordView()
    }
}
