import SwiftUI

// MARK: - OffsetObservableScrollView

struct OffsetObservableScrollView<Content: View>: View {
    var axes: Axis.Set = .vertical
    var showsIndicators: Bool = true

    @Binding var scrollOffset: CGPoint
    @ViewBuilder var content: (ScrollViewProxy) -> Content

    @Namespace private var coordinateSpaceName

    init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        scrollOffset: Binding<CGPoint>,
        @ViewBuilder content: @escaping (ScrollViewProxy) -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self._scrollOffset = scrollOffset
        self.content = content
    }

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            ScrollViewReader { scrollViewProxy in
                content(scrollViewProxy)
                    .background(
                        GeometryReader { geometryProxy in
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: CGPoint(
                                        x: -geometryProxy.frame(in: .named(coordinateSpaceName)).minX,
                                        y: -geometryProxy.frame(in: .named(coordinateSpaceName)).minY
                                    )
                                )
                        }
                    )
            }
        }
        .coordinateSpace(name: coordinateSpaceName)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
}

// MARK: - ScrollOffsetPreferenceKey

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

// MARK: - View Extensions

public extension View {
    @ViewBuilder
    func onReadSize(_ perform: @escaping (CGSize) -> Void) -> some View {
        background {
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: perform)
    }

    @ViewBuilder
    func `if`<Content: View>(
        _ condition: @autoclosure () -> Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

public struct SizePreferenceKey: PreferenceKey {
    public static var defaultValue: CGSize = .zero
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

// MARK: - SubView

struct SubView: View {
    let colors: [Color]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<colors.count, id: \.self) { index in
                Rectangle()
                    .fill(colors[index])
                    .frame(width: 150, height: 150)
                    .cornerRadius(12)
            }
        }
    }
}

// MARK: - Main View

struct ScrollOffsetView: View {
    let evenIndexColors: [Color] = [.green, .yellow, .red, .blue]
    let oddIndexColors: [Color] = [.red, .brown, .blue, .orange, .gray]

    @State private var scrollOffset: CGPoint = .zero
    @State private var evenViewWidth: CGFloat = .zero
    @State private var oddViewWidth: CGFloat = .zero

    var body: some View {
        OffsetObservableScrollView(.horizontal, scrollOffset: $scrollOffset) { _ in
            VStack(alignment: .leading, spacing: 30) {
                SubView(colors: evenIndexColors)
                    .onReadSize { size in
                        evenViewWidth = size.width
                    }
                    .if(evenViewWidth < oddViewWidth) {
                        $0.offset(
                            x: scrollOffset.x * ((1 - (evenViewWidth / oddViewWidth) + 0.14))
                        )
                    }

                SubView(colors: oddIndexColors)
                    .onReadSize { size in
                        oddViewWidth = size.width
                    }
            }
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    ScrollOffsetView()
}

