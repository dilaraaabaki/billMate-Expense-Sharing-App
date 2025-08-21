import SwiftUI

struct CreateHouseGroupView: View {
    @State private var groupName = ""
    @State private var selectedMemberCount = 1
    @State private var isShowingDropdown = false
    @State private var isCreatingGroup = false
    
    let memberCountOptions = Array(1...5)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack(spacing: 16) {
                    Text("Ev Grubunuzu Oluşturun")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Aramıza katılman için sabırsızlanıyoruz!")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                VStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Grup Adı")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextField("Grubunuzun adını girin", text: $groupName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Kişi Sayısı")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Button(action: {
                            withAnimation {
                                isShowingDropdown.toggle()
                            }
                        }) {
                            HStack {
                                Text("\(selectedMemberCount) kişi")
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: isShowingDropdown ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .bold))
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                        }
                        
                        if isShowingDropdown {
                            VStack(spacing: 0) {
                                ForEach(memberCountOptions, id: \.self) { count in
                                    Button(action: {
                                        selectedMemberCount = count
                                        withAnimation {
                                            isShowingDropdown = false
                                        }
                                    }) {
                                        HStack {
                                            Text("\(count) kişi")
                                                .foregroundColor(.primary)
                                            Spacer()
                                            if selectedMemberCount == count {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding()
                                        .background(count == memberCountOptions.first ? Color(.systemGray5) : Color.clear)
                                    }
                                    .background(Color(.systemGray6))
                                    
                                    if count != memberCountOptions.last {
                                        Divider()
                                            .padding(.leading)
                                    }
                                }
                            }
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    isCreatingGroup = true
                    print("Grup adı: \(groupName), Kişi sayısı: \(selectedMemberCount)")
                }) {
                    Text("Oluştur")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                .disabled(groupName.isEmpty)
                .opacity(groupName.isEmpty ? 0.6 : 1)
            }
            .navigationBarTitle("", displayMode: .inline)
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .onTapGesture {
                if isShowingDropdown {
                    withAnimation {
                        isShowingDropdown = false
                    }
                }
            }
        }
    }
}

struct CreateHouseGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHouseGroupView()
    }
}
