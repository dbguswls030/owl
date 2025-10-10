import Domain
import SwiftUI

struct MainView: View {
    @EnvironmentObject var diContainerWrapper: DIContainerWrapper
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?
    private var isEditing: Bool {
        selectedImage != nil
    }
    @State private var next = false
    @State private var isPresentedAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                } else {
                    Text("No Image Selected")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                PhotoPickerView(showPhotoPicker: $showPhotoPicker)
            }
            .sheet(isPresented: $showPhotoPicker) {
                PHPhotoPickerView(selectedImage: $selectedImage)
            }
            .background(.black)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("이미지 선택")
                        .foregroundStyle(.white)
                }
                if isEditing {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isPresentedAlert = true
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .alert(
                            "사진 초기화",
                            isPresented: $isPresentedAlert
                            ) {
                                Button("초기화", role: .destructive) {
                                    selectedImage = nil
                                    isPresentedAlert = false
                                }
                                Button("취소", role: .cancel) {
                                    isPresentedAlert = false
                                }
                            } message: {
                                Text("선택된 사진을 초기화하시겠습니까?")
                            }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            next = true
                        } label: {
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.white)
                        }
                        .disabled(!isEditing)
                    }
                }
            }
            .navigationDestination(isPresented: $next) {
                if let selectedImage = selectedImage {
                    EditView(selectedImage: selectedImage)
                }
            }
        }
    }
}

#Preview {
    class MockSavePhotoUseCase: SavePhotoUseCase {
        func execute(data: Data) async throws {}
    }

    class MockDIContainer: DIContainerProtocol {
        func makeSavePhotoUseCase() -> SavePhotoUseCase {
            MockSavePhotoUseCase()
        }
    }

    let mockContainer = MockDIContainer()
    let wrapper = DIContainerWrapper(container: mockContainer)
    return MainView()
        .environmentObject(wrapper)
}
