import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("Hoşgeldin! Evini kontrol")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                    Text("etmeye hazır mısın?")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                VStack(spacing: 16) {
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
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Şifre", text: $password)
                                .font(.system(size: 16))
                        } else {
                            SecureField("Şifre", text: $password)
                                .font(.system(size: 16))
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.1))
                    )
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    Button(action: {
                    }) {
                        Text("Şifremi Unuttum?")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                }) {
                    Text("Giriş Yap")
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
            
            HStack {
                Text("Hesabın yok mu?")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Button(action: {
                }) {
                    Text("Kayıt Ol")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 30)
            
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.black)
                .frame(width: 134, height: 5)
                .padding(.bottom, 20)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
