import SwiftUI
import Charts

struct ExpenseData {
    let id = UUID()
    let category: String
    let amount: Double
    let color: Color
}

struct TransactionItem {
    let id = UUID()
    let name: String
    let amount: String
    let color: Color
    let userInitials: String
    let userName: String
}

// MARK: - Bottom Navigation Bar
struct BottomNavigationBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation buttons
            HStack {
                // Home
                Button(action: { selectedTab = 0 }) {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Search
                Button(action: { selectedTab = 1 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Add (Plus button - larger and centered)
                Button(action: { selectedTab = 2 }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 56, height: 56)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Settings
                Button(action: { selectedTab = 3 }) {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == 3 ? "gearshape.fill" : "gearshape")
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == 3 ? .blue : .gray)
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Profile
                Button(action: { selectedTab = 4 }) {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == 4 ? .blue : .gray)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 12)
            .padding(.horizontal, 20)
            .background(Color(.systemGray6))
            
            // Home indicator
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.black)
                .frame(width: 134, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 8)
        }
        .background(Color(.systemGray6))
    }
}

// MARK: - All Expenses View
struct TumMasraflarView: View {
    @Environment(\.presentationMode) var presentationMode
    let transactions: [TransactionItem]
    @State private var showingFilter = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with filter
            headerWithFilter
            
            // Date Range
            dateRangeView
            
            // Expenses List
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(transactions, id: \.id) { transaction in
                        expenseRow(transaction)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 100) // Space for bottom navbar
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
    
    private var headerWithFilter: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            
            Spacer()
            
            Text("Tüm Masraflar")
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {
                showingFilter.toggle()
            }) {
                Image(systemName: "line.3.horizontal.decrease")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(.systemBackground))
    }
    
    private var dateRangeView: some View {
        HStack {
            Text("Kasım 2024 - Aralık 2025")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
    }
    
    private func expenseRow(_ transaction: TransactionItem) -> some View {
        HStack(spacing: 12) {
            // User Profile Image
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 45, height: 45)
                
                Text(transaction.userInitials)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            
            // Transaction Details
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(transaction.amount)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Detail Button
            Button(action: {}) {
                Text("Detay")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(6)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(transaction.color)
        .cornerRadius(12)
    }
}

// MARK: - Placeholder Views for other tabs
struct SearchView: View {
    var body: some View {
        VStack {
            Text("Arama")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

struct AddExpenseView: View {
    var body: some View {
        VStack {
            Text("Masraf Ekle")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Ayarlar")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profil")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

// MARK: - Home Page
struct HomePage: View {
    @State private var showAllExpenses = false
    @State private var expenseData = [
        ExpenseData(category: "Kira", amount: 76.4, color: .yellow.opacity(0.7)),
        ExpenseData(category: "Faturalar", amount: 12.5, color: .green.opacity(0.6)),
        ExpenseData(category: "Ortak Giderler", amount: 6.9, color: .blue.opacity(0.6)),
        ExpenseData(category: "Diğer", amount: 4.2, color: .pink.opacity(0.6))
    ]
    
    @State private var transactions = [
        TransactionItem(name: "Market Alışverişi", amount: "200,00 TL", color: .green.opacity(0.3), userInitials: "MA", userName: "Mehmet Ali"),
        TransactionItem(name: "Ocak Ayı Kira", amount: "5.500,00 TL", color: .yellow.opacity(0.3), userInitials: "AY", userName: "Ayşe Yılmaz"),
        TransactionItem(name: "Doğalgaz Faturası", amount: "500,00 TL", color: .blue.opacity(0.3), userInitials: "FK", userName: "Fatma Kaya"),
        TransactionItem(name: "Lambader alışverişi", amount: "500,00 TL", color: .purple.opacity(0.3), userInitials: "HS", userName: "Hasan Sözen"),
        TransactionItem(name: "Manav Alışverişi", amount: "200,00 TL", color: .green.opacity(0.3), userInitials: "EA", userName: "Elif Arslan"),
        TransactionItem(name: "Benzin", amount: "400,00 TL", color: .red.opacity(0.3), userInitials: "BB", userName: "Bülent Baki"),
        TransactionItem(name: "Kahve", amount: "150,00 TL", color: .brown.opacity(0.3), userInitials: "SB", userName: "Selin Başak"),
        TransactionItem(name: "Kitap", amount: "80,00 TL", color: .blue.opacity(0.3), userInitials: "DA", userName: "Deniz Ak"),
        TransactionItem(name: "Sinema", amount: "120,00 TL", color: .purple.opacity(0.3), userInitials: "BT", userName: "Burak Tekin"),
        TransactionItem(name: "Spor Salonu", amount: "300,00 TL", color: .orange.opacity(0.3), userInitials: "NY", userName: "Nazlı Yurt")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Chart Section (Fixed at top)
                chartSection
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                // Transactions Section (Scrollable)
                transactionsSection
                    .padding(.top, 30)
                    .padding(.bottom, 100) // Space for bottom navbar
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
        .sheet(isPresented: $showAllExpenses) {
            TumMasraflarView(transactions: transactions)
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            
            Spacer()
            
            Text("Anasayfa")
                .font(.title2)
                .fontWeight(.medium)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "trash")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
    }
    
    private var chartSection: some View {
        VStack(spacing: 15) {
            // Pie Chart
            ZStack {
                Chart(expenseData, id: \.category) { data in
                    SectorMark(
                        angle: .value("Amount", data.amount),
                        innerRadius: .ratio(0.4),
                        outerRadius: .ratio(0.8)
                    )
                    .foregroundStyle(data.color)
                }
                .frame(height: 200)
                
                // Center text
                VStack {
                    Button(action: {
                        showAllExpenses = true
                    }) {
                        Text("Tümünü Gör")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            // Legend
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(expenseData, id: \.category) { data in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(data.color)
                            .frame(width: 12, height: 12)
                        
                        Text(data.category)
                            .font(.caption)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(data.amount, specifier: "%.1f")%")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(15)
    }
    
    private var transactionsSection: some View {
        LazyVStack(spacing: 12) {
            ForEach(transactions, id: \.id) { transaction in
                transactionRow(transaction)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func transactionRow(_ transaction: TransactionItem) -> some View {
        HStack(spacing: 15) {
            // User Profile Circle
            ZStack {
                Circle()
                    .fill(transaction.color)
                    .frame(width: 50, height: 50)
                
                Text(transaction.userInitials)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            
            // Transaction Info
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                HStack(spacing: 8) {
                    Text(transaction.userName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Circle()
                        .fill(Color.secondary)
                        .frame(width: 3, height: 3)
                    
                    Text(transaction.amount)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Detail Button
            Button(action: {}) {
                Text("Detay")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding(15)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Main Content Wrapper
struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Main content based on selected tab
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Bottom Navigation Bar
            VStack {
                Spacer()
                BottomNavigationBar(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(.keyboard)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

// MARK: - App Entry Point
struct HomePage_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
