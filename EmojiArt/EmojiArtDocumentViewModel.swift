import SwiftUI
import Combine

class EmojiArtDocumentViewModel: ObservableObject {
    
    static let palette: String =  "🐶🐱🐹🐰🦊🐼🐨🐯🐸🐵🐧🐦🐤🦆🦅🦇🐺"

    private static let emojiArtDocumentKey = "EmojiArtDocumentViewModel.Untitled"
    
    @Published private var emojiArtModel: EmojiArtModel
    private var emojiArtModelSink: AnyCancellable?
    @Published private(set) var backgroundImage: UIImage?
    var emojis: [EmojiArtModel.Emoji] { emojiArtModel.emojis }

    var backgroundURL: URL? {
        get {
            emojiArtModel.backgroundURL
        }
        set {
            emojiArtModel.backgroundURL = newValue?.imageURL
            fetchBackgroundImageData()
        }
    }

    //
    init() {
        let emojiArtJson = UserDefaults.standard.data(forKey: EmojiArtDocumentViewModel.emojiArtDocumentKey)
        emojiArtModel = EmojiArtModel(json: emojiArtJson) ?? EmojiArtModel() //if nil, create new empty model
        emojiArtModelSink = $emojiArtModel.sink { emojiArtModel in
            print("JSON: \(emojiArtModel.json?.utf8 ?? "nil")")
            UserDefaults.standard.set(emojiArtModel.json, forKey: EmojiArtDocumentViewModel.emojiArtDocumentKey)
        }
        fetchBackgroundImageData() //load background data
    }
    
    // MARK: - Intents
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArtModel.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }

    private var fetchImageSink: AnyCancellable?
    private func fetchBackgroundImageData() {
        fetchImageSink?.cancel()
        backgroundImage = nil
        if let url = emojiArtModel.backgroundURL {
            fetchImageSink = URLSession.shared.dataTaskPublisher(for: url)
                .map { data, response in UIImage(data: data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { fetchedImage in
                    self.backgroundImage = fetchedImage
                }
        }
    }
}

extension EmojiArtModel.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: x, y: y) }
}
