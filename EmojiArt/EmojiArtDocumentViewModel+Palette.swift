import Foundation

extension EmojiArtDocumentViewModel {
    private static let palettesPersistenceKey = "EmojiArtDocument.PalettesKey"
    private static let defaultPalettes = [
        "๐คฏ๐ค๐๐ฅณ๐คฉ๐๐๐๐คฃ๐คก๐ค๐ค๐ช๐คข๐คง๐คฎ๐๐๐คช๐ง": "Faces",
        "๐ถ๐ฑ๐น๐ฐ๐ฆ๐ผ๐จ๐ฏ๐ธ๐ต๐ง๐ฆ๐ค๐ฆ๐ฆ๐ฆ๐บ": "Animals",
        "๐๐๐๐ง๐ถ๐ฅฆ๐๐ฅฅ๐ฅ๐๐ฅญ๐๐": "Food",
        "๐น๐ชโฝ๏ธ๐น๐ฑ๐ฅ๐๐คนโโ๏ธ๐ฉฐ๐จ๐ฏ๐ฎ๐ฒโ๐ธ": "Activities"
    ]

    private(set) var paletteNames: [String: String] {
        get {
            UserDefaults.standard.object(forKey: EmojiArtDocumentViewModel.palettesPersistenceKey) as? [String: String]
                ?? EmojiArtDocumentViewModel.defaultPalettes
        }
        set {
            UserDefaults.standard.set(newValue, forKey: EmojiArtDocumentViewModel.palettesPersistenceKey)
            objectWillChange.send()
        }
    }

    var sortedPalettesByName: [String] {
        paletteNames.keys.sorted { paletteNames[$0]! < paletteNames[$1]! }
    }

    var defaultPalette: String {
        sortedPalettesByName.first ?? "โ ๏ธ"
    }

    func renamePalette(_ palette: String, to name: String) {
        paletteNames[palette] = name
    }

    @discardableResult
    func addEmoji(_ emoji: String, toPalette palette: String) -> String {
        let newPalette = (emoji + palette).uniqued()
        return changePalette(palette, to: newPalette)
    }

    @discardableResult
    func removeEmojis(_ emojisToRemove: String, fromPalette palette: String) -> String {
        let newPalette = palette.filter { !emojisToRemove.contains($0) }
        return changePalette(palette, to: newPalette)
    }

    private func changePalette(_ palette: String, to newPalette: String) -> String {
        let name = paletteNames[palette] ?? ""
        paletteNames[palette] = nil
        paletteNames[newPalette] = name
        return newPalette
    }

    func palette(after referencePalette: String) -> String {
        palette(offsetBy: +1, from: referencePalette)
    }

    func palette(before referencePalette: String) -> String {
        palette(offsetBy: -1, from: referencePalette)
    }

    private func palette(offsetBy offset: Int, from referencePalette: String) -> String {
        if let currentIndex = sortedPalettesByName.firstIndex(of: referencePalette) {
            let newIndex = (currentIndex + (offset >= 0 ? offset : paletteNames.keys.count - abs(offset) % paletteNames.keys.count)) % paletteNames.keys.count
            return sortedPalettesByName[newIndex]
        } else {
            return defaultPalette
        }
    }
}
