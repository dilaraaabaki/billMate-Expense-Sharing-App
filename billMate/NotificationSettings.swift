import SwiftUI

struct NotificationSettingsView: View {
    // State variables to hold the toggle values
    @State private var sendExpenseNotifications = true
    @State private var groupChangeNotifications = false
    @State private var appNotifications = false
    @State private var updateSettingsNotifications = false

    var body: some View {
        Form {
            Section(header: Text("MASRAFLAR")) {
                Toggle("Masraflar ile ilgili bildirim gönder", isOn: $sendExpenseNotifications)
            }
            
            Section(header: Text("GRUP AYARLARI")) {
                Toggle("Grup ile ilgili değişiklikler", isOn: $groupChangeNotifications)
            }
            
            Section(header: Text("UYGULAMA BİLDİRİMLERİ")) {
                Toggle("Bildirimler", isOn: $appNotifications)
                Toggle("Güncelleme Ayarları", isOn: $updateSettingsNotifications)
            }
        }
        .navigationTitle("Bildirim Ayarları")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotificationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationSettingsView()
        }
    }
}
