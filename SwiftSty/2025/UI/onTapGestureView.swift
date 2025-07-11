import SwiftUI

struct User {
    let name: String
}

struct TapGestureExample: View {
    @State private var location: CGPoint = .zero

    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .fill(self.location.y > 50 ? Color.yellow : Color.gray)
                .frame(width: 200, height: 200)
                .onTapGesture(count: 1, coordinateSpace: .global) { location in
                    self.location = location
                }

            Text("탭 자표 값: \(Int(location.x)), \(Int(location.y))")
                .fontWeight(.bold)
        }
    }
}

#Preview {
    TapGestureExample()
}

