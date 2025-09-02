//
//  2025_09_01_VisionOSApp.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/1/25.
//

//
//  2025_09_01_VisionOSApp.swift
//  HelloVisionOS
//
//  Created by 김은찬 on 9/1/25.
//

//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct VisionOSApp: View {
//    @State private var entity: Entity?
//    @State private var rotationAngle: Float = 0 // 회전 값
//    @State private var colorToggle = false      // 색상
//    
//    var body: some View {
//        VStack {
//            RealityView { content in
//                if let sceneEntity = try? await Entity(named: "Scene", in: realityKitContentBundle) {
//                    sceneEntity.generateCollisionShapes(recursive: true)
//                    
//                    if let model = sceneEntity as? ModelEntity {
//                        model.model?.materials = [SimpleMaterial(color: .blue, isMetallic: true)]
//                    }
//                    
//                    content.add(sceneEntity)
//                    entity = sceneEntity
//                }
//            }
//            .frame(width: 400, height: 400)
//            // SwiftUI 제스처 연결
//            .gesture(
//                TapGesture()
//                    .onEnded {
//                        guard let model = entity as? ModelEntity else { return }
//                        
//                        // 회전
//                        rotationAngle += .pi / 4
//                        model.transform.rotation = simd_quatf(angle: rotationAngle, axis: [0,1,0])
//                        
//                        // 색상 토글
//                        colorToggle.toggle()
//                        model.model?.materials = [
//                            SimpleMaterial(
//                                color: colorToggle ? .red : .blue,
//                                isMetallic: true
//                            )
//                        ]
//                    }
//            )
//            
//            Text("모델을 눌러 회전 변형 시켜 보세요!")
//                .padding(.top, 30)
//        }
//    }
//}
//
//#Preview(windowStyle: .automatic) {
//    ContentView()
//}
