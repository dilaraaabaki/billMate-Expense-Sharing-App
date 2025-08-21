import SwiftUI

struct Expense {
    let title: String
    let subTitle: String
    let category: String
    let amount: String
    let date: String
    let time: String
    let description: String
    let categoryIconName: String
    let receiptImageName: String
}

let sampleExpense = Expense(
    title: "Masraf Detayları",
    subTitle: "Example",
    category: "Kira",
    amount: "5.500,00 TL",
    date: "27/12/2024",
    time: "21:00",
    description: "Ocak Ayı Ev Kirası",
    categoryIconName: "house.fill",
    receiptImageName: "receipt"
)


struct DetailItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.headline)
                .foregroundColor(.primary)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}


struct ExpenseDetail: View {
    
    let expense: Expense

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(expense.title)
                                    .font(.title2).bold()
                                Text(expense.subTitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 8) {
                                Image(systemName: expense.categoryIconName)
                                    .font(.title)
                                    .foregroundColor(.orange)
                                    .frame(width: 70, height: 70)
                                    .background(Color.orange.opacity(0.2))
                                    .cornerRadius(16)
                                
                                Button(action: { /* PDF download action */ }) {
                                    Label("PDF İndir", systemImage: "icloud.and.arrow.down")
                                        .font(.caption)
                                        .padding(8)
                                        .background(Color.gray.opacity(0.15))
                                        .clipShape(Capsule())
                                }
                                .foregroundColor(.secondary)
                            }
                        }
                        
                        HStack(alignment: .top, spacing: 16) {
                            VStack(alignment: .leading, spacing: 16) {
                                DetailItem(label: "Kategori", value: expense.category)
                                DetailItem(label: "Tutar", value: expense.amount)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                DetailItem(label: "Tarih", value: expense.date)
                                DetailItem(label: "Saat", value: expense.time)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                       
                        Divider()
                
                        DetailItem(label: "Açıklama", value: expense.description)
                     
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Fotoğraf")
                                .font(.headline)
                            
                            Image(expense.receiptImageName)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                }
                .padding()
            }
            .background(Color(.systemGray6))
            .navigationTitle("Masraf Detayları")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { /* Back action */ }) {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { /* Delete action */ }) {
                        Image(systemName: "trash")
                    }
                }
            }
            .tint(.primary)
        }
    }
}

struct ExpenseDetail_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetail(expense: sampleExpense)
    }
}
