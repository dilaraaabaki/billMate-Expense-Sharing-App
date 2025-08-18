import SwiftUI
import LinkPresentation // Needed for the rich link preview

// --- 1. DATA MODELS ---
struct Housemate: Identifiable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var registrationDate: Date
}

struct CurrentUser {
    let id: UUID
    let name: String
    var isAdmin: Bool
}

// --- 2. SHARE SHEET HELPERS ---

// A custom class to provide rich link data (title, URL) to the share sheet.
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

// A SwiftUI wrapper for the UIKit UIActivityViewController.
struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


// --- 3. DETAIL VIEW ---
struct HousemateDetailView: View {
    let housemate: Housemate
    let currentUser: CurrentUser
    var onDelete: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Housemate Information")) {
                HStack { Text("Name"); Spacer(); Text(housemate.name).foregroundColor(.secondary) }
                HStack { Text("Email"); Spacer(); Text(housemate.email).foregroundColor(.secondary) }
                HStack { Text("Member Since"); Spacer(); Text(housemate.registrationDate, style: .date).foregroundColor(.secondary) }
            }
            
            if currentUser.isAdmin && currentUser.id != housemate.id {
                Section {
                    Button(role: .destructive) {
                        onDelete()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Delete Housemate").frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
        .navigationTitle(housemate.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


// --- 4. MAIN LIST VIEW (UPDATED) ---
struct HousematesView: View {
    
    // --- STATE MANAGEMENT ---
    @State private var housemates: [Housemate] = [
        Housemate(id: UUID(), name: "Example Example", email: "example@email.com", registrationDate: Date()),
        Housemate(id: UUID(), name: "Example 2", email: "example2@email.com", registrationDate: Date())
    ]
    
    // The current user is now hardcoded.
    // In a real app, you would get this data after a user logs in.
    // Set `isAdmin` to `false` to test the non-admin experience.
    @State private var currentUser = CurrentUser(id: UUID(), name: "Admin User", isAdmin: true)
    
    // State to control the presentation of the share sheet
    @State private var isShowingShareSheet = false
    
    // The invitation link to be shared
    let inviteLink = URL(string: "https://appname.com/invite?code=12345ABCDE")!

    // --- VIEW BODY ---
    var body: some View {
        NavigationView {
            // The list of housemates.
            List {
                ForEach(housemates) { housemate in
                    NavigationLink(destination: HousemateDetailView(
                        housemate: housemate,
                        currentUser: currentUser,
                        onDelete: { deleteHousemate(housemate) }
                    )) {
                        HStack {
                            Text(housemate.name)
                            if housemate.id == currentUser.id {
                                Text("(You)").font(.caption).foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("Detail").foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Ev Arkadaşları")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // This button triggers the share sheet
                    Button(action: {
                        self.isShowingShareSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // This modifier presents the share sheet when isShowingShareSheet is true
            .sheet(isPresented: $isShowingShareSheet) {
                let linkSource = CustomLinkSource(
                    title: "Uygulama Davet Linki",
                    url: inviteLink
                )
                ActivityViewController(activityItems: [linkSource])
            }
        }
        .onAppear(perform: addUserToList)
    }
    
    // --- ACTION FUNCTIONS ---
    private func deleteHousemate(_ housemateToDelete: Housemate) {
        housemates.removeAll { $0.id == housemateToDelete.id }
    }
    
    private func addUserToList() {
        if !housemates.contains(where: { $0.id == currentUser.id }) {
            let userAsHousemate = Housemate(id: currentUser.id, name: currentUser.name, email: "admin@you.com", registrationDate: Date())
            housemates.insert(userAsHousemate, at: 0)
        }
    }
}

// --- 5. PREVIEW ---
struct HousematesView_Previews: PreviewProvider {
    static var previews: some View {
        HousematesView()
    }
}
