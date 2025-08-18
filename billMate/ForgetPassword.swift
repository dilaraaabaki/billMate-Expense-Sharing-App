import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Main content
            VStack(spacing: 30) {
                // Title
                Text("Şifremi Unuttum?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                // Subtitle/Description
                Text("Merak etme! Bu meydana gelir. Lütfen hesabınıza bağlı e-posta adresini girin.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                // Email input field
                TextField("Emailinizi Girin", text: $email)
                    .font(.system(size: 16))
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .padding(.horizontal, 20)
                
                // Send code button
                Button(action: {
                    // Send reset code action
                }) {
                    Text("Kodu Gönder")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.yellow.opacity(0.7))
                        )
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
            Spacer()
            
            // Back to login link
            HStack {
                Text("Şifrenizi hatırlıyor musunuz?")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Navigate back to login
                }) {
                    Text("Giriş Yap")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 30)
            
            // Home indicator
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.black)
                .frame(width: 134, height: 5)
                .padding(.bottom, 20)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
