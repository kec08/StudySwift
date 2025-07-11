import SwiftUI

struct StickyView: View {
    @State private var selectedTab: String = "First"
    
    var body: some View {
        VStack {
            Text("Sticky View")
                .font(.title)
                .bold()
            
            ScrollViewReader { proxy in
                ScrollView {
                    TopView()
                    
                    LazyVStack(spacing: 10, pinnedViews: .sectionHeaders) {
                        Section(
                            header: StickHeaderView(
                                selectedTab: $selectedTab,
                                action: {
                                    withAnimation {
                                        proxy.scrollTo("Header", anchor: .top)
                                    }
                                }
                            )
                        ) {
                            switch selectedTab {
                            case "First":
                                ItemsView(color: .blue)
                            case "Second":
                                ItemsView(color: .yellow)
                            default:
                                ItemsView(color: .green, count: 2)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - 상단 뷰
struct TopView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Here is Top")
                .font(.title)
                .bold()
            Spacer()
        }
        .background(Color.green.opacity(0.5))
        .frame(height: 50)
    }
}

// MARK: - 고정될 헤더 뷰
struct StickHeaderView: View {
    @Binding var selectedTab: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                selectedTab = "First"
                action()
            }) {
                Text("First")
                    .font(.title)
                    .bold()
                    .foregroundColor(selectedTab == "First" ? .black : .gray)
            }
            
            Button(action: {
                selectedTab = "Second"
            }) {
                Text("Second")
                    .font(.title)
                    .bold()
                    .foregroundColor(selectedTab == "Second" ? .black : .gray)
            }
            
            Button(action: {
                selectedTab = "Third"
            }) {
                Text("Third")
                    .font(.title)
                    .bold()
                    .foregroundColor(selectedTab == "Third" ? .black : .gray)
            }
            
            Spacer()
        }
        .background(.white)
        .id("Header")
    }
}

// MARK: - 콘텐츠 뷰
struct ItemsView: View {
    let color: Color
    let count: Int
    
    init(color: Color, count: Int = 20) {
        self.color = color
        self.count = count
    }
    
    var body: some View {
        VStack {
            ForEach(0..<count, id: \.self) { _ in
                Rectangle()
                    .fill(color)
                    .cornerRadius(10)
                    .frame(height: 100)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(minHeight: UIScreen.main.bounds.height - 150)
    }
}

#Preview {
    StickyView()
}

