import SwiftUI

// UIActivityViewController wrapper for SwiftUI
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {}
}

struct AddMembers: View {
    @State private var groupName: String = ""
    @State private var showingShareSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Status bar area
            Rectangle()
                .fill(Color.clear)
                .frame(height: 44)
            
            // Header with time and status indicators
            HStack {
                Text("9:41")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 4) {
                    // Signal bars
                    HStack(spacing: 2) {
                        ForEach(0..<4) { index in
                            RoundedRectangle(cornerRadius: 1)
                                .fill(Color.black)
                                .frame(width: 3, height: CGFloat(4 + index * 2))
                        }
                    }
                    
                    // WiFi icon
                    Image(systemName: "wifi")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.black)
                    
                    // Battery
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.black)
                        .frame(width: 24, height: 12)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            
            // Main content
            VStack(alignment: .leading, spacing: 40) {
                // Group name section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Grup Adı")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                    
                    TextField("Grup Adı", text: $groupName)
                        .font(.system(size: 17))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // Add person section
                HStack {
                    Text("Kişi Ekle")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        showingShareSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            // Bottom button
            VStack {
                Button(action: {
                    // Accept and save action
                }) {
                    Text("Kabul Et ve Kaydol")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.yellow.opacity(0.7))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                // Home indicator
                RoundedRectangle(cornerRadius: 2.5)
                    .fill(Color.black)
                    .frame(width: 134, height: 5)
                    .padding(.bottom, 10)
            }
        }
        .background(Color.white)
        .ignoresSafeArea()
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [
                "Uygulama Davet Linki",
                URL(string: "https://appname.com/invite?code=12345ABCDE") ?? ""
            ])
        }
    }
}

struct AddMembers_Previews: PreviewProvider {
    static var previews: some View {
        AddMembers()
    }
}
