//
//  2025_08_20_RefreshableScrollView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/20/25.
//

import SwiftUI

public struct RefreshOffsetObservableScrollView<Content: View>: View {
  @State private var isRefreshing = false
  var axes: Axis.Set = .vertical
  var showsIndicators: Bool = true
  @Binding var scrollOffset: CGPoint
  var onRefresh: (() -> Void)?
  @ViewBuilder var content: (ScrollViewProxy) -> Content
  @Namespace var coordinateSpaceName: Namespace.ID
  
  public init(
    _ axes: Axis.Set = .vertical,
    showsIndicators: Bool = true,
    scrollOffset: Binding<CGPoint>,
    onRefresh: (() -> Void)? = nil,
    @ViewBuilder content: @escaping (ScrollViewProxy) -> Content
  ) {
    self.axes = axes
    self.showsIndicators = showsIndicators
    self._scrollOffset = scrollOffset
    self.onRefresh = onRefresh
    self.content = content
  }
  
  public var body: some View {
    ScrollView(axes, showsIndicators: showsIndicators) {
      ScrollViewReader { scrollViewProxy in
        ZStack(alignment: .top) {
          if onRefresh != nil {
            RefreshIndicator(isRefreshing: isRefreshing, offset: scrollOffset.y)
              .frame(height: 0)
          }
          
          content(scrollViewProxy)
            .id("top")
            .background {
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
            }
            .onChange(of: scrollOffset) { newOffset in
              if newOffset == .zero {
                withAnimation {
                  scrollViewProxy.scrollTo("top", anchor: .top)
                }
              }
            }
        }
      }
    }
    .coordinateSpace(name: coordinateSpaceName)
    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
      scrollOffset = value
      
      if let onRefresh = onRefresh,
         value.y < -100,
         !isRefreshing {
        isRefreshing = true
        onRefresh()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          isRefreshing = false
        }
      }
    }
  }
}

// MARK: - 리프레쉬 인디케이터
private struct RefreshIndicator: View {
  let isRefreshing: Bool
  let offset: CGFloat
  
  var body: some View {
    if offset < 0 {
      ProgressView()
        .scaleEffect(min(abs(offset) / 50, 1))
        .frame(height: max(abs(offset), 0))
    }
  }
}


struct RefreshableScrollView: View {
  @State var scrollOffset: CGPoint = .zero
  @State var isDisplayTopView: Bool = false
  
  var body: some View {
    VStack {
      if isDisplayTopView {
        Text("리프레쉬 성공!")
      }
      
      RefreshOffsetObservableScrollView(
        scrollOffset: $scrollOffset,
        onRefresh: {
          isDisplayTopView = true
        }
      ) { _ in
        Rectangle()
          .fill(.green)
          .frame(height: 400)
          .padding(.top, 30)
      }
    }
    .padding()
  }
}

#Preview {
    RefreshableScrollView()
}
