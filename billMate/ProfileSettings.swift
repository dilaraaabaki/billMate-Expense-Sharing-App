import SwiftUI

struct ProfileSettingsView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(Color(.systemGray4))
                
                Button(action: {}) {
                    Text("Edit")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .padding(.vertical, 20)
            
            // Form Section
            VStack(spacing: 0) {
                profileInfoRow(title: "Ad Soyad", value: "Ayşe Yılmaz")
                Divider()
                profileInfoRow(title: "Email", value: "ayseyilmaz@icloud.com")
                Divider()
                profileInfoRow(title: "Şifre", value: "●●●●●●", isSecure: true)
            }
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                print("Çıkış Yap tapped")
            }) {
                Text("Çıkış Yap")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Profil Ayarları")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func profileInfoRow(title: String, value: String, isSecure: Bool = false) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(.systemGray3))
        }
        .padding()
        .contentShape(Rectangle()) 
    }
}


// MARK: - Preview
struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileSettingsView()
        }
    }
}
