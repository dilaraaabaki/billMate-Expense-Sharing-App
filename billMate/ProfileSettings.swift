import SwiftUI

struct ProfileSettingsView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Profile Image Section
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
                profileInfoRow(title: "Ad Soyad", value: "Example Example")
                Divider()
                profileInfoRow(title: "Email", value: "example@gmail.com")
                Divider()
                profileInfoRow(title: "Şifre", value: "●●●●●●", isSecure: true)
            }
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
            
            // Logout Button
            Button(action: {
                // Handle logout action
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
    
    // Helper function to create each row in the profile info section
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
        .contentShape(Rectangle()) // Make the whole row tappable
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
