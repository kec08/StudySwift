//
//  TextView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import SwiftUI

public struct CustomTextView: UIViewRepresentable {
  @Binding var text: String
  @Binding var height: CGFloat
  var maxHeight: CGFloat
  var textFont: UIFont
  var textColor: UIColor = .black
  var textLimit: Int = 10
  var cornerRadius: CGFloat? = nil
  var borderWidth: CGFloat? = nil
  var borderColor: CGColor? = nil
  var isScrollEnabled: Bool = true
  var isEditable: Bool = true
  var isUserInteractionEnabled: Bool = true
  var lineFragmentPadding: CGFloat = 0
  var textContainerInset: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
  var placeholder: String? = nil
  var placeholderColor: UIColor = .gray
  
  public func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    
    if let cornerRadius = cornerRadius {
      textView.layer.cornerRadius = cornerRadius
      textView.layer.masksToBounds = true
    }
    if let borderWidth = borderWidth {
      textView.layer.borderWidth = borderWidth
    }
    if let borderColor = borderColor {
      textView.layer.borderColor = borderColor
    }
    if let placeholder = placeholder {
      textView.text = placeholder
      textView.textColor = placeholderColor
    } else {
      textView.textColor = textColor
    }
    
    textView.font = textFont
    textView.isScrollEnabled = isScrollEnabled
    textView.isEditable = isEditable
    textView.isUserInteractionEnabled = isUserInteractionEnabled
    textView.textContainer.lineFragmentPadding = lineFragmentPadding
    textView.textContainerInset = textContainerInset
    textView.delegate = context.coordinator
    textView.becomeFirstResponder()
    
    return textView
  }
  
  public func updateUIView(_ uiView: UITextView, context: Context) {
    updateHeight(uiView)
  }
  
  public func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  private func updateHeight(_ uiView: UITextView) {
    let size = uiView.sizeThatFits(CGSize(width: uiView.frame.width, height: .infinity))
    DispatchQueue.main.async {
      if size.height <= maxHeight {
        height = size.height
      }
    }
  }
  
  public class Coordinator: NSObject, UITextViewDelegate {
    var parent: CustomTextView
    
    init(parent: CustomTextView) {
      self.parent = parent
    }
    
    public func textViewDidChange(_ textView: UITextView) {
      parent.text = textView.text
      
      if textView.text.isEmpty {
        textView.textColor = parent.placeholderColor
      } else {
        textView.textColor = parent.textColor
      }
      
      if textView.text.count > parent.textLimit {
        textView.text.removeLast()
      }
      
      parent.updateHeight(textView)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.text == parent.placeholder {
        textView.text = ""
      }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
        textView.text = parent.placeholder
      }
    }
  }
}

struct TextView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Spacer()
        .frame(height: 100)
      
      Button(
        action: {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        },
        label: {
          Text("Hide Keyboard")
        }
      )
      
      Spacer()
      
      TextWritingView()
        .background(.gray)
    }
  }
}

private struct TextWritingView: View {
  @State private var height: CGFloat = 30
  @State var text: String = ""
    private var registerButtonDisabled: Bool {
    text.isEmpty
  }
  private var registerButtonTextColor: Color {
    text.isEmpty ? .red : .green
  }
  
  var body: some View {
    HStack(alignment: .bottom, spacing: 10) {
      // 댓글 입력창
      CustomTextView(
        text: $text,
        height: $height,
        maxHeight: 200,
        textFont: .boldSystemFont(ofSize: 14),
        cornerRadius: 5,
        borderWidth: 1,
        borderColor: CGColor.init(red: 255, green: 255, blue: 255, alpha: 1),
        placeholder: "댓글을 입력해 주세요"
      )
      .frame(minHeight: height, maxHeight: .infinity)
      
      // 등록 버튼
      Button(
        action: {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        },
        label: {
          Text("등록")
            .foregroundColor(registerButtonTextColor)
        }
      )
      .disabled(registerButtonDisabled)
      .padding(.bottom, 5)
    }
    .padding(.all, 10)
    .frame(height: 50)
    .frame(minHeight: height + 20)
  }
}

#Preview{
    TextView()
}
