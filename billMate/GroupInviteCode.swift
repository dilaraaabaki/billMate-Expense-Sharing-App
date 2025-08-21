import SwiftUI

struct GroupInviteCodeView: View {
    @State private var inviteCode: String = ""
    @State private var timeRemaining: String = "00:00"
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 30) {
                Text("Grup Davet Kodu")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Text("Ev arkadaşının gönderdiği davet kodunu gir! Evinizi kontrol etmeye başlayın!")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                TextField("Kodu Girin", text: $inviteCode)
                    .font(.system(size: 17))
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
                    .padding(.horizontal, 20)
                
                Text(timeRemaining)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                
                Button(action: {
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
            
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.black)
                .frame(width: 134, height: 5)
                .padding(.bottom, 20)
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea()
    }
}

struct GroupInviteCodeView_Previews: PreviewProvider {
    static var previews: some View {
        GroupInviteCodeView()
    }
}
