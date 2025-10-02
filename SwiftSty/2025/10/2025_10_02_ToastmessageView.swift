//
//  2025_10_02_ToastmessageView.swift
//  SwiftSty
//
//  Created by 김은찬 on 10/2/25.
//

import SwiftUI

enum FancyToastStyle {
    case error
    case warning
    case success
    case info
}

extension FancyToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

struct FancyToast: Equatable {
    var type: FancyToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}


struct FancyToastView: View {
    var type: FancyToastStyle
    var title: String
    var message: String
    var onCancelTapped: (() -> Void)
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: type.iconFileName)
                    .foregroundColor(type.themeColor)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 10)
                
                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
            }
            .padding()
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

struct FancyToastModifier: ViewModifier {
    @Binding var toast: FancyToast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                FancyToastView(
                    type: toast.type,
                    title: toast.title,
                    message: toast.message) {
                        dismissToast()
                    }
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
               dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    func toastView(toast: Binding<FancyToast?>) -> some View {
        self.modifier(FancyToastModifier(toast: toast))
    }
}

struct ToastBasicView: View {
    @State private var toast: FancyToast? = nil
    var body: some View {
        VStack {
            Button {
                toast = FancyToast(type: .info, title: "제목으로 안내해봅니다", message: "문제 없이 아주 잘 되었습니다 이것은 메시지입니다")
            } label: {
                Text("안내")
            }
            Button {
                toast = FancyToast(type: .error, title: "제목으로 에러 발생시켜봅니다", message: "문제가 있을때 나오는 오류 메시지입니다")
            } label: {
                Text("오류")
            }
            Button {
                toast = FancyToast(type: .warning, title: "제목으로 경고합니다", message: "주의해야할때 나오는 경고 메시지입니다")
            } label: {
                Text("경고")
            }
            Button {
                toast = FancyToast(type: .success, title: "제목으로 성공 알립니다", message: "문제가 있을때 나오는 오류 메시지입니다")
            } label: {
                Text("성공")
            }
            
        }
        .toastView(toast: $toast)
    }
}

struct ToastmessageView: View {
    var body: some View {
        VStack {
            ToastBasicView()
        }
    }
}

#Preview {
    ToastmessageView()
}
