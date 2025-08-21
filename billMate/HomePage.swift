import SwiftUI
import Charts

// MARK: - Veri Modelleri
struct ExpenseData: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
    let color: Color
}

struct TransactionItem: Identifiable {
    let id = UUID()
    let name: String
    let amount: String
    let color: Color
    let userInitials: String
    let userName: String
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        mainContent
            .overlay(alignment: .bottom) {
                BottomNavigationBar(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @ViewBuilder
    private var mainContent: some View {
        Group {
            switch selectedTab {
            case 0:
                HomePage()
            case 1:
                SearchView()
            case 2:
                AddExpenseView()
            case 3:
                SettingsView()
            case 4:
                ProfileView()
            default:
                HomePage()
            }
        }
    }
}
struct HomePage: View {
    @State private var showAllExpenses = false
    @State private var expenseData = [
        ExpenseData(category: "Kira", amount: 76.4, color: .yellow.opacity(0.7)),
        ExpenseData(category: "Faturalar", amount: 12.5, color: .green.opacity(0.6)),
        ExpenseData(category: "Ortak Giderler", amount: 6.9, color: .blue.opacity(0.6)),
        ExpenseData(category: "Diğer", amount: 4.2, color: .pink.opacity(0.6))
    ]
    @State private var transactions = [
        TransactionItem(name: "Market Alışverişi", amount: "200,00 TL", color: .green.opacity(0.1), userInitials: "MA", userName: "Mehmet Ali"),
        TransactionItem(name: "Ocak Ayı Kira", amount: "5.500,00 TL", color: .yellow.opacity(0.1), userInitials: "AY", userName: "Ayşe Yılmaz")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    chartSection
                        .padding(.horizontal)
                    
                    transactionsSection
                        .padding(.horizontal)
                    
                    Spacer().frame(height: 100)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Anasayfa")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAllExpenses) {
                TumMasraflarView(transactions: transactions)
            }
        }
    }
    
    private var chartSection: some View {
        VStack(spacing: 15) {
            ZStack {
                Chart(expenseData) { data in
                    SectorMark(angle: .value("Amount", data.amount), innerRadius: .ratio(0.75))
                        .foregroundStyle(data.color)
                }
                .frame(height: 200)
                VStack {
                    Text("Toplam Harcama").font(.subheadline).foregroundColor(.secondary)
                    Text("8.950,00 TL").font(.title2).bold()
                }
            }
            Button("Tümünü Gör") {
                showAllExpenses = true
            }
            .font(.caption).fontWeight(.medium)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(expenseData) { data in
                    HStack(spacing: 8) {
                        Circle().fill(data.color).frame(width: 18, height: 18)
                        Text(data.category).font(.caption)
                        Spacer()
                        Text("\(data.amount, specifier: "%.1f")%").font(.caption).fontWeight(.medium).foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
    }
    
    private var transactionsSection: some View {
        VStack {
            HStack {
                Text("Son İşlemler").font(.headline)
                Spacer()
            }
            LazyVStack(spacing: 12) {
                ForEach(transactions) { transactionRow($0) }
            }
        }
    }
    
    private func transactionRow(_ transaction: TransactionItem) -> some View {
        HStack(spacing: 15) {
            ZStack {
                Circle().fill(transaction.color.opacity(0.5)).frame(width: 50, height: 50)
                Text(transaction.userInitials).fontWeight(.semibold)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.name).fontWeight(.medium)
                Text(transaction.userName).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
            Text(transaction.amount).fontWeight(.medium)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
struct SearchView: View { var body: some View { Text("Arama Sayfası") } }
struct AddExpenseView: View { var body: some View { Text("Masraf Ekle Sayfası") } }
struct SettingsView: View { var body: some View { Text("Ayarlar Sayfası") } }
struct ProfileView: View { var body: some View { Text("Profil Sayfası") } }
struct BottomNavigationBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(alignment: .top) {
            navButton(icon: "house", tab: 0)
            navButton(icon: "magnifyingglass", tab: 1)
            plusButton()
            navButton(icon: "gearshape", tab: 3)
            navButton(icon: "person", tab: 4)
        }
        .padding(.top, 12)
        .frame(height: 85, alignment: .top) // DÜZELTME: Sabit yükseklik verdik
        .background(.thinMaterial) // DÜZELTME: Modern bir arka plan efekti
    }
    
    private func navButton(icon: String, tab: Int) -> some View {
        Button(action: { selectedTab = tab }) {
            Image(systemName: selectedTab == tab ? "\(icon).fill" : icon)
                .font(.system(size: 24))
                .foregroundColor(selectedTab == tab ? .accentColor : .gray)
                .frame(maxWidth: .infinity)
        }
    }
    
    private func plusButton() -> some View {
        Button(action: { selectedTab = 2 }) {
            ZStack {
                Circle().fill(Color.accentColor).frame(width: 56, height: 56).shadow(radius: 4)
                Image(systemName: "plus").font(.system(size: 26, weight: .medium)).foregroundColor(.white)
            }
        }
        .offset(y: -20) // DÜZELTME: Offset'i biraz azalttık
        .frame(maxWidth: .infinity)
    }
}

struct TumMasraflarView: View {
    @Environment(\.dismiss) var dismiss
    let transactions: [TransactionItem]
    
    var body: some View {
        NavigationStack {
            List(transactions) { transaction in
                HStack {
                    Text(transaction.userInitials).padding(10).background(Circle().fill(transaction.color.opacity(0.3)))
                    VStack(alignment: .leading) {
                        Text(transaction.name)
                        Text(transaction.userName).font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(transaction.amount)
                }
            }
            .navigationTitle("Tüm Masraflar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Kapat") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
