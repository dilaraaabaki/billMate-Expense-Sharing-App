import SwiftUI

struct Profile: View {
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            ScrollView {
                VStack(spacing: 30) {
                    profileSection
                    menuSection
                }
                .padding(.top, 30)
            }
            
            // Çıkış Yap butonunu en alta ekliyoruz
            Button(action: {
                print("Çıkış Yap tapped")
            }) {
                Text("Çıkış Yap")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
    
    private var headerView: some View {
        HStack {
            Spacer()
            Text("Profil")
                .font(.system(size: 24, weight: .semibold))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(.systemBackground))
    }
    
    private var profileSection: some View {
        VStack(spacing: 15) {
            ZStack {
                Circle().fill(Color(.systemGray4)).frame(width: 80, height: 80)
                Image(systemName: "person.fill").font(.system(size: 35)).foregroundColor(.white)
            }
            VStack(spacing: 5) {
                Text("Ayşe Yılmaz").font(.system(size: 18, weight: .medium))
                Text("ayseyilmaz@icloud.com").font(.system(size: 14)).foregroundColor(.secondary)
            }
        }
    }
    
    private var menuSection: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: ProfileSettings()) { // Changed to ProfileSettings
                menuItemContent(icon: "gearshape.fill", iconColor: .gray, title: "Profil Ayarları")
            }
            
            Divider().padding(.leading, 63)
            
            Button(action: { print("Tapped: Grup Ayarları") }) {
                menuItemContent(icon: "person.2.fill", iconColor: .orange, title: "Grup Ayarları")
            }
            
            Divider().padding(.leading, 63)
            
            NavigationLink(destination: NotificationSettingsView()) {
                menuItemContent(icon: "bell.fill", iconColor: .red, title: "Bildirimler")
            }
            
            Divider().padding(.leading, 63)
            
            Button(action: { print("Tapped: Gizlilik & Güvenlik") }) {
                menuItemContent(icon: "lock.shield.fill", iconColor: .blue, title: "Gizlilik & Güvenlik")
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
    
    private func menuItemContent(icon: String, iconColor: Color, title: String) -> some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 6).fill(iconColor).frame(width: 28, height: 28)
                Image(systemName: icon).font(.system(size: 14, weight: .medium)).foregroundColor(.white)
            }
            Text(title).font(.system(size: 16)).foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right").font(.system(size: 14, weight: .medium)).foregroundColor(Color(.systemGray3))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .contentShape(Rectangle())
    }
}

struct ProfileSettings: View { // This is the correct struct name
    var body: some View {
        Text("Profil Ayarları Sayfası")
            .navigationTitle("Profil Ayarları")
    }
}

struct NotificationSettingsView: View {
    var body: some View {
        Text("Bildirim Ayarları Sayfası")
            .navigationTitle("Bildirimler")
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Profile()
        }
    }
}
