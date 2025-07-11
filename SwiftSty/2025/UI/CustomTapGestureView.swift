//
//  SimultaneousGestursView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/19/25.
//

import SwiftUI


public struct CustomTapGesture: Gesture {
  public typealias Value = SimultaneousGesture<TapGesture, DragGesture>.Value
  
  let count: Int
  let coordinateSpace: CoordinateSpace
  
  init(
    count: Int = 1,
    coordinateSpace: CoordinateSpace = .global
  ) {
    self.count = count
    self.coordinateSpace = coordinateSpace
  }
  
  public var body: SimultaneousGesture<TapGesture, DragGesture> {
    SimultaneousGesture(
      TapGesture(count: count),
      DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
    )
  }
  
  public func onEnded(perform action: @escaping (CGPoint) -> Void) -> _EndedGesture<CustomTapGesture> {
    self.onEnded { (value: Value) -> Void in
      guard value.first != nil else { return }
      guard let location = value.second?.startLocation else { return }
      guard let endLocation = value.second?.location else { return }
      guard ((location.x-1)...(location.x+1))
        .contains(endLocation.x), ((location.y-1)...(location.y+1))
        .contains(endLocation.y) else {
        return
      }
      action(location)
    }
  }
}

extension View {
  public func onCustomTapGesture(
    count: Int,
    coordinateSpace: CoordinateSpace = .global,
    perform action: @escaping (CGPoint) -> Void
  ) -> some View {
    simultaneousGesture(CustomTapGesture(count: count, coordinateSpace: coordinateSpace)
      .onEnded(perform: action)
    )
  }
  
  public func onCustomTapGesture(
    count: Int,
    perform action: @escaping (CGPoint) -> Void
  ) -> some View {
    onCustomTapGesture(count: count, coordinateSpace: .global, perform: action)
  }
  
  public func onCustomTapGesture(
    perform action: @escaping (CGPoint) -> Void
  ) -> some View {
    onCustomTapGesture(count: 1, coordinateSpace: .global, perform: action)
  }
}

struct CustomTapGestureView: View {
  @State private var location: CGPoint = .zero
  
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
        .onCustomTapGesture { location in
          self.location = location
        }
      
      Text("Get position of Tap Gesture")
        .onCustomTapGesture { location in
          self.location = location
        }
      
      Circle()
        .fill(self.location.y > 350 ? Color.blue : Color.red)
        .frame(width: 100, height: 100, alignment: .center)
        .onCustomTapGesture { location in
          self.location = location
        }
      
      Text("current position is \(location.x) \(location.y)")
    }
    .padding()
  }
}

#Preview {
    CustomTapGestureView()
}
