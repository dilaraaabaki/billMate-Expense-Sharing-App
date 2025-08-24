import SwiftUI
import LinkPresentation

struct Housemate: Identifiable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var phone: String?
    var registrationDate: Date
    var profileImage: String?
}

struct CurrentUser {
    let id: UUID
    let name: String
    var isAdmin: Bool
}

class CustomLinkSource: NSObject, UIActivityItemSource {
    var title: String
    var url: URL
    
    init(title: String, url: URL) {
        self.title = title
        self.url = url
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return url
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return url
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.url = url
        metadata.title = title
        return metadata
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct HousemateDetailView: View {
    let housemate: Housemate
    let currentUser: CurrentUser
    var onDelete: () -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var body: some View {
        Form {
            // Profile Section
            Section {
                HStack {
                    // Profile Image
                    if let profileImage = housemate.profileImage {
                        Image(profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(housemate.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        if housemate.id == currentUser.id {
                            Text("You")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(Color.blue.opacity(0.1))
                                .clipShape(Capsule())
                        }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Contact Information")) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                        .frame(width: 24)
                    Text("Email")
                    Spacer()
                    Text(housemate.email)
                        .foregroundColor(.secondary)
                }
                
                if let phone = housemate.phone {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.green)
                            .frame(width: 24)
                        Text("Phone")
                        Spacer()
                        Text(phone)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Section(header: Text("Member Information")) {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.orange)
                        .frame(width: 24)
                    Text("Member Since")
                    Spacer()
                    Text(housemate.registrationDate, style: .date)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.purple)
                        .frame(width: 24)
                    Text("Days as Member")
                    Spacer()
                    Text("\(daysSinceRegistration()) days")
                        .foregroundColor(.secondary)
                }
            }
            
            // Quick Actions Section
            if housemate.id != currentUser.id {
                Section(header: Text("Quick Actions")) {
                    Button(action: {
                        callHousemate()
                    }) {
                        HStack {
                            Image(systemName: "phone")
                                .foregroundColor(.green)
                                .frame(width: 24)
                            Text("Call")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                    .foregroundColor(.primary)
                    
                    Button(action: {
                        sendMessage()
                    }) {
                        HStack {
                            Image(systemName: "message")
                                .foregroundColor(.blue)
                                .frame(width: 24)
                            Text("Send Message")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            
            // Admin Actions Section
            if currentUser.isAdmin && currentUser.id != housemate.id {
                Section(header: Text("Admin Actions")) {
                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        HStack {
                            Image(systemName: "person.badge.minus")
                                .foregroundColor(.red)
                                .frame(width: 24)
                            Text("Remove from Group")
                            Spacer()
                        }
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .navigationTitle(housemate.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Remove Housemate", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Remove", role: .destructive) {
                onDelete()
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Are you sure you want to remove \(housemate.name) from the group? This action cannot be undone.")
        }
    }
    
    private func daysSinceRegistration() -> Int {
        Calendar.current.dateComponents([.day], from: housemate.registrationDate, to: Date()).day ?? 0
    }
    
    private func callHousemate() {
        if let phone = housemate.phone,
           let url = URL(string: "tel:\(phone.replacingOccurrences(of: " ", with: ""))") {
            UIApplication.shared.open(url)
        }
    }
    
    private func sendMessage() {
        if let phone = housemate.phone,
           let url = URL(string: "sms:\(phone.replacingOccurrences(of: " ", with: ""))") {
            UIApplication.shared.open(url)
        }
    }
}

struct HousematesView: View {
    
    @State private var housemates: [Housemate] = [
        Housemate(id: UUID(), name: "Example Example", email: "example@email.com", phone: "+90 555 123 4567", registrationDate: Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()),
        Housemate(id: UUID(), name: "Example 2", email: "example2@email.com", phone: "+90 555 987 6543", registrationDate: Calendar.current.date(byAdding: .day, value: -15, to: Date()) ?? Date())
    ]
    
    @State private var currentUser = CurrentUser(id: UUID(), name: "Admin User", isAdmin: true)
    
    @State private var isShowingShareSheet = false
    @State private var showingLeaveGroupAlert = false
    @State private var showingDeleteAccountAlert = false
    
    let inviteLink = URL(string: "https://appname.com/invite?code=12345ABCDE")!

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    // Group Info Section
                    Section(header: Text("Group Members (\(housemates.count))")) {
                        ForEach(housemates) { housemate in
                            NavigationLink(destination: HousemateDetailView(
                                housemate: housemate,
                                currentUser: currentUser,
                                onDelete: { deleteHousemate(housemate) }
                            )) {
                                HousemateRowView(housemate: housemate, currentUser: currentUser)
                            }
                        }
                    }
                    
                    // Group Actions Section
                    Section(header: Text("Group Actions")) {
                        Button(action: {
                            isShowingShareSheet = true
                        }) {
                            HStack {
                                Image(systemName: "person.badge.plus")
                                    .foregroundColor(.blue)
                                    .frame(width: 24)
                                Text("Invite New Member")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(.primary)
                    }
                    
                    // Account Actions Section
                    Section(header: Text("Account Actions")) {
                        Button(action: {
                            showingLeaveGroupAlert = true
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(.orange)
                                    .frame(width: 24)
                                Text("Leave Group")
                                Spacer()
                            }
                        }
                        .foregroundColor(.orange)
                        
                        Button(action: {
                            showingDeleteAccountAlert = true
                        }) {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.xmark")
                                    .foregroundColor(.red)
                                    .frame(width: 24)
                                Text("Delete Account")
                                Spacer()
                            }
                        }
                        .foregroundColor(.red)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Grup Ayarları")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingShareSheet = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $isShowingShareSheet) {
                let linkSource = CustomLinkSource(
                    title: "Uygulama Davet Linki",
                    url: inviteLink
                )
                ActivityViewController(activityItems: [linkSource])
            }
            .alert("Leave Group", isPresented: $showingLeaveGroupAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Leave", role: .destructive) {
                    leaveGroup()
                }
            } message: {
                Text("Are you sure you want to leave this group? You will need an invitation to join again.")
            }
            .alert("Delete Account", isPresented: $showingDeleteAccountAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deleteAccount()
                }
            } message: {
                Text("Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.")
            }
        }
        .onAppear(perform: addUserToList)
    }
    
    private func deleteHousemate(_ housemateToDelete: Housemate) {
        housemates.removeAll { $0.id == housemateToDelete.id }
    }
    
    private func addUserToList() {
        if !housemates.contains(where: { $0.id == currentUser.id }) {
            let userAsHousemate = Housemate(
                id: currentUser.id,
                name: currentUser.name,
                email: "admin@you.com",
                phone: "+90 555 000 0000",
                registrationDate: Calendar.current.date(byAdding: .day, value: -45, to: Date()) ?? Date()
            )
            housemates.insert(userAsHousemate, at: 0)
        }
    }
    
    private func leaveGroup() {
        // Implement leave group functionality
        print("User left the group")
        // You can add navigation back to login/home screen here
    }
    
    private func deleteAccount() {
        // Implement delete account functionality
        print("User account deleted")
        // You can add navigation back to registration screen here
    }
}

struct HousemateRowView: View {
    let housemate: Housemate
    let currentUser: CurrentUser
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Image or Icon
            if let profileImage = housemate.profileImage {
                Image(profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 44))
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(housemate.name)
                        .font(.headline)
                        .lineLimit(1)
                    
                    if housemate.id == currentUser.id {
                        Text("(You)")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                }
                
                Text(housemate.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                if let phone = housemate.phone {
                    Text(phone)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding(.vertical, 4)
    }
}

struct HousematesView_Previews: PreviewProvider {
    static var previews: some View {
        HousematesView()
            .preferredColorScheme(.light)
        
        HousematesView()
            .preferredColorScheme(.dark)
    }
}
