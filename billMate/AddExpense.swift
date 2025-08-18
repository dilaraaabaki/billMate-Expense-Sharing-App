import SwiftUI

// A reusable style for the form fields to maintain consistency.
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

// A reusable style for the primary action button.
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
    // State variables to hold the form data
    @State private var selectedCategory = "Kategori"
    @State private var date = Date()
    @State private var amount = ""
    @State private var description = ""
    
    // Sample categories for the picker
    private let categories = ["Food", "Transport", "Shopping", "Utilities", "Entertainment"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Category and Date Fields
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
                        
                        // Date Picker
                        VStack(alignment: .leading) {
                            Text("Tarih")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .labelsHidden()
                                .modifier(FormFieldStyle())
                        }
                    }
                    
                    // MARK: - Amount Field
                    VStack(alignment: .leading) {
                        Text("Tutar")
                           .font(.subheadline)
                           .foregroundColor(.gray)
                        TextField("Tutar", text: $amount)
                            .keyboardType(.decimalPad)
                            .modifier(FormFieldStyle())
                    }
                    
                    // MARK: - Description Field
                    VStack(alignment: .leading) {
                        Text("Açıklama")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $description)
                                .frame(height: 120)
                                .modifier(FormFieldStyle())
                            
                            // Placeholder for TextEditor
                            if description.isEmpty {
                                Text("Açıklama")
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding(16)
                                    .allowsHitTesting(false)
                            }
                        }
                    }
                    
                    // MARK: - Attachment Buttons
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
                    
                    // Spacer to push the button to the bottom
                    Spacer(minLength: 20)

                    // MARK: - Submit Button
                    Button("Masraf Ekle") {
                        // Action to add the expense
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
