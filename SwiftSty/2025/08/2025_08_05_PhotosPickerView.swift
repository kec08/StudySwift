//
//  2025_08_05_PhotosPickerView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/5/25.
//

import SwiftUI
import PhotosUI

public struct SilverPhotoPicker<Content: View>: View {
  @State private var selectedPhotos: [PhotosPickerItem]
  @Binding private var selectedImages: [UIImage]
  @Binding private var isPresentedError: Bool
  private let maxSelectedCount: Int
  private var disabled: Bool {
    selectedImages.count >= maxSelectedCount
  }
  private var availableSelectedCount: Int {
    maxSelectedCount - selectedImages.count
  }
  private let matching: PHPickerFilter
  private let photoLibrary: PHPhotoLibrary
  private let content: () -> Content
  
  public init(
    selectedPhotos: [PhotosPickerItem] = [],
    selectedImages: Binding<[UIImage]>,
    isPresentedError: Binding<Bool> = .constant(false),
    maxSelectedCount: Int = 5,
    matching: PHPickerFilter = .images,
    photoLibrary: PHPhotoLibrary = .shared(),
    content: @escaping () -> Content
  ) {
    self.selectedPhotos = selectedPhotos
    self._selectedImages = selectedImages
    self._isPresentedError = isPresentedError
    self.maxSelectedCount = maxSelectedCount
    self.matching = matching
    self.photoLibrary = photoLibrary
    self.content = content
  }
  
  public var body: some View {
    PhotosPicker(
      selection: $selectedPhotos,
      maxSelectionCount: availableSelectedCount,
      matching: matching,
      photoLibrary: photoLibrary
    ) {
      content()
        .disabled(disabled)
    }
    .disabled(disabled)
    .onChange(of: selectedPhotos) { _, newValue in
      handleSelectedPhotos(newValue)
    }
  }
  
  private func handleSelectedPhotos(_ newPhotos: [PhotosPickerItem]) {
    for newPhoto in newPhotos {
      newPhoto.loadTransferable(type: Data.self) { result in
        switch result {
        case .success(let data):
          if let data = data, let newImage = UIImage(data: data) {
            if !selectedImages.contains(where: { $0.pngData() == newImage.pngData() }) {
              DispatchQueue.main.async {
                selectedImages.append(newImage)
              }
            }
          }
        case .failure:
          isPresentedError = true
        }
      }
    }
    
    selectedPhotos.removeAll()
  }
}

struct PhotosPickerView: View {
    @State private var selectedImages: [UIImage] = []
    @State private var isPresentedError: Bool = false

    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        VStack {
            SilverPhotoPicker(
                selectedImages: $selectedImages,
                isPresentedError: $isPresentedError,
                maxSelectedCount: 9
            ) {
                Label("사진 선택", systemImage: "photo")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if !selectedImages.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("선택된 이미지가 없습니다.")
                    .foregroundColor(.gray)
                    .padding(.top)
            }
        }
        .alert("이미지를 불러오는 중 오류가 발생했습니다.", isPresented: $isPresentedError) {
            Button("확인", role: .cancel) {}
        }
    }
}

#Preview {
    PhotosPickerView()
}
