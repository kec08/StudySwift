//
//  2025_08_25_StrokedTextView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/25/25.
//

import SwiftUI

public class StrokedLabel: UILabel {
    var strokeWidth: CGFloat = 5.0 {
        didSet { setNeedsDisplay() }
    }
    var strokeColor: UIColor = .black {
        didSet { setNeedsDisplay() }
    }
    
    public override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(strokeWidth)
        context?.setLineJoin(.round)
        
        // 외곽선 그리기
        context?.setTextDrawingMode(.stroke)
        textColor = strokeColor
        super.drawText(in: rect)
        
        // 외곽선 내부 채우기
        context?.setTextDrawingMode(.fill)
        textColor = strokeColor.withAlphaComponent(0)
        super.drawText(in: rect)
        
        // 실제 텍스트 그리기
        textColor = .white
        super.drawText(in: rect)
    }
}

public struct StrokedText: UIViewRepresentable {
    let text: String
    let strokeWidth: CGFloat
    let strokeColor: UIColor
    let foregroundColor: UIColor
    let font: UIFont
    var numberOfLines: Int
    var kerning: CGFloat
    var lineHeight: CGFloat?
    var textAlignment: NSTextAlignment
    
    // UIViewRepresentable 구현
    public func makeUIView(context: Context) -> StrokedLabel {
        let label = StrokedLabel()
        updateUIView(label, context: context)
        return label
    }
    
    public func updateUIView(_ label: StrokedLabel, context: Context) {
        // 기본 속성 설정
        label.strokeWidth = strokeWidth
        label.strokeColor = strokeColor
        label.font = font
        
        // AttributedString 설정
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count)
        
        var attributes: [NSAttributedString.Key: Any] = [
            .kern: kerning,
            .foregroundColor: foregroundColor,
            .font: font
        ]
        
        // 줄 높이 설정
        if let lineHeight = lineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            paragraphStyle.alignment = textAlignment
            paragraphStyle.lineBreakMode = .byTruncatingTail
            attributes[.paragraphStyle] = paragraphStyle
        }
        
        attributedString.addAttributes(attributes, range: range)
        label.attributedText = attributedString
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
    }
}

public extension StrokedText {
    func lineLimit(_ limit: Int?) -> StrokedText {
        var view = self
        view.numberOfLines = limit ?? 0
        return view
    }
    
    func multilineTextAlignment(_ alignment: TextAlignment) -> StrokedText {
        var view = self
        switch alignment {
        case .leading:
            view.textAlignment = .left
        case .trailing:
            view.textAlignment = .right
        case .center:
            view.textAlignment = .center
        }
        return view
    }
    
    func kerning(_ value: CGFloat) -> StrokedText {
        var view = self
        view.kerning = value
        return view
    }
    
    func lineHeight(_ value: CGFloat) -> StrokedText {
        var view = self
        view.lineHeight = value
        return view
    }
}

struct StrokedTextView: View {
  var body: some View {
    StrokedText(
      text: "Hello, Eunchan!",
      strokeWidth: 5,
      strokeColor: .systemPink,
      foregroundColor: .white,
      font: .systemFont(ofSize: 24, weight: .bold),
      numberOfLines: 1,
      kerning: 0,
      textAlignment: .center
    )
    .kerning(2)
  }
}


#Preview {
    StrokedTextView()
}
