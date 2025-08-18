import SwiftUI

struct RegisterView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isAgreedToTerms: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with "Register" title
            HStack {
                Text("Register")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .padding(.bottom, 40)
            
            // Main content
            VStack(spacing: 30) {
                // Welcome message
                VStack(spacing: 8) {
                    Text("Tekrar hoşgeldiniz! Seni")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                    Text("gördüğüme sevindim,")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                    Text("Tekrar!")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                // Form fields
                VStack(spacing: 16) {
                    // Full Name
                    TextField("Ad Soyad", text: $fullName)
                        .font(.system(size: 16))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.1))
                        )
                    
                    // Email
                    TextField("Email", text: $email)
                        .font(.system(size: 16))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.1))
                        )
                    
                    // Password
                    SecureField("Şifre", text: $password)
                        .font(.system(size: 16))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.1))
                        )
                    
                    // Confirm Password
                    SecureField("Şifreyi Tekrar Girin", text: $confirmPassword)
                        .font(.system(size: 16))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.1))
                        )
                }
                .padding(.horizontal, 20)
                
                // Terms and conditions checkbox
                HStack {
                    Button(action: {
                        isAgreedToTerms.toggle()
                    }) {
                        Image(systemName: isAgreedToTerms ? "checkmark.square.fill" : "square")
                            .font(.system(size: 18))
                            .foregroundColor(isAgreedToTerms ? .blue : .gray)
                    }
                    
                    Text("Kullanım koşullarını kabul ediyorum")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                // Register button
                Button(action: {
                    // Register action
                }) {
                    Text("Kabul Et ve Kaydol")
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
