import SwiftUI

struct OTPVerificationView: View {
    @State private var otpCode: [String] = ["", "", ""]
    @FocusState private var focusedField: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Main content
            VStack(spacing: 40) {
                // Title and description
                VStack(spacing: 16) {
                    Text("Kod Doğrulaması")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("E-posta adresinize az önce gönderdiğimiz doğrulama kodunu girin.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                
                // OTP Input Fields
                HStack(spacing: 16) {
                    ForEach(0..<3, id: \.self) { index in
                        OTPInputField(
                            text: $otpCode[index],
                            isActive: focusedField == index,
                            onTap: {
                                focusedField = index
                            },
                            onTextChange: { oldValue, newValue in
                                handleTextChange(at: index, oldValue: oldValue, newValue: newValue)
                            }
                        )
                        .focused($focusedField, equals: index)
                    }
                }
                .padding(.horizontal, 20)
                
                // Verify button
                Button(action: {
                    // Verify OTP action
                    let fullCode = otpCode.joined()
                    print("Verifying OTP: \(fullCode)")
                }) {
                    Text("Doğrula")
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
            
            // Resend code link
            HStack {
                Text("Kodu alamadınız mı?")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Resend code action
                }) {
                    Text("Tekrar Gönder")
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
        .background(Color(.systemGray6))
        .ignoresSafeArea()
        .onAppear {
            // Auto-focus first field when view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                focusedField = 0
            }
        }
        .onTapGesture {
            // Tap anywhere to focus first empty field or last field
            if let emptyIndex = otpCode.firstIndex(where: { $0.isEmpty }) {
                focusedField = emptyIndex
            } else {
                focusedField = 2
            }
        }
    }
    
    private func handleTextChange(at index: Int, oldValue: String, newValue: String) {
        // Limit to single digit
        if newValue.count > 1 {
            otpCode[index] = String(newValue.prefix(1))
        }
        
        // Auto-advance to next field
        if !newValue.isEmpty && index < 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                focusedField = index + 1
            }
        }
        
        // Auto-move back if deleting
        if newValue.isEmpty && !oldValue.isEmpty && index > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                focusedField = index - 1
            }
        }
    }
}

struct OTPInputField: View {
    @Binding var text: String
    let isActive: Bool
    let onTap: () -> Void
    let onTextChange: (String, String) -> Void
    
    var body: some View {
        TextField("", text: $text)
            .font(.system(size: 24, weight: .medium))
            .multilineTextAlignment(.center)
            .frame(width: 60, height: 60)
            .keyboardType(.numberPad)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.cyan.opacity(0.6), lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
            )
            .onChange(of: text) { oldValue, newValue in
                onTextChange(oldValue, newValue)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onTap()
            }
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
