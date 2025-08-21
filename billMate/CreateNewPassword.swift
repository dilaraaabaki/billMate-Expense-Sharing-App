import SwiftUI

struct CreateNewPasswordView: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                VStack(spacing: 40) {
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
                
                VStack(spacing: 16) {
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
                
                Button(action: {
                    if validatePasswords() {
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
            
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.black)
                .frame(width: 134, height: 5)
                .padding(.bottom, 20)
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea()
    }
    
    private func validatePasswords() -> Bool {
        guard !newPassword.isEmpty && !confirmPassword.isEmpty else {
            return false
        }
        
        guard newPassword == confirmPassword else {
            return false
        }
        
        return true
    }
}

struct CreateNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPasswordView()
    }
}
