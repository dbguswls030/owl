public enum PhotoError: Error {
    case conversionFailed
    case authorizationDenied
    case saveFailed(Error?)

    public var errorDescription: String {
        switch self {
        case .conversionFailed:
            "이미지를 데이터로 변환하는 데 실패했습니다."
        case .authorizationDenied:
            "사진 앨범 접근 권한이 거부되었습니다. 설정에서 권한을 허용해 주세요."
        case .saveFailed:
            "알 수 없는 오류로 사진 저장에 실패하였습니다."
        }
    }
}
