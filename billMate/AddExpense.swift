import SwiftUI

struct FormFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.yellow.opacity(0.4))
            .foregroundColor(.black)
            .font(.headline)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}


struct AddExpense: View {
    @State private var selectedCategory = "Kategori"
    @State private var date = Date()
    @State private var amount = ""
    @State private var description = ""
    
    private let categories = ["Kira", "Faturalar", "Ortak Giderler", "Diğer"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
         
                    HStack(spacing: 16) {
                        // Category Picker
                        VStack(alignment: .leading) {
                            Text("Kategori")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Menu {
                                ForEach(categories, id: \.self) { category in
                                    Button(category) {
                                        self.selectedCategory = category
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedCategory)
                                        .foregroundColor(selectedCategory == "Kategori" ? .gray.opacity(0.6) : .black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .modifier(FormFieldStyle())
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Tarih")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .labelsHidden()
                                .modifier(FormFieldStyle())
                        }
                    }
              
                    VStack(alignment: .leading) {
                        Text("Tutar")
                           .font(.subheadline)
                           .foregroundColor(.gray)
                        TextField("Tutar", text: $amount)
                            .keyboardType(.decimalPad)
                            .modifier(FormFieldStyle())
                    }
                  
                    VStack(alignment: .leading) {
                        Text("Açıklama")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $description)
                                .frame(height: 120)
                                .modifier(FormFieldStyle())
                            
                            if description.isEmpty {
                                Text("Açıklama")
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding(16)
                                    .allowsHitTesting(false)
                            }
                        }
                    }
                    
                    HStack(spacing: 16) {
                        Button(action: { /* Add photo action */ }) {
                            HStack {
                                Text("Fotoğraf Ekle")
                                Spacer()
                                Image(systemName: "square.and.arrow.up")
                            }
                            .frame(maxWidth: .infinity)
                            .modifier(FormFieldStyle())
                        }
                        
                        Button(action: { /* Download PDF action */ }) {
                            HStack {
                                Text("PDF İndir")
                                Spacer()
                                Image(systemName: "icloud.and.arrow.down")
                            }
                            .frame(maxWidth: .infinity)
                            .modifier(FormFieldStyle())
                        }
                    }
                    .foregroundColor(.black)
                   
                    Spacer(minLength: 20)

                    Button("Masraf Ekle") {
                        print("Expense Added")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                }
                .padding()
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
            .navigationTitle("Masraf Ekle")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                // Back button action
            }) {
                Image(systemName: "chevron.left")
            })
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense()
    }
}
