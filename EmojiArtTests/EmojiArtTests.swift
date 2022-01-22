import XCTest
@testable import EmojiArt

class EmojiArtTests: XCTestCase {
    
    private var document: EmojiArtDocumentViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        document = EmojiArtDocumentViewModel.init()
    }
    
    func testAddEmoji_whenTextIsEmpty_doesNothing() throws {
        let emojiCount = document.defaultPalette.count
        
        document.addEmoji("", toPalette: document.defaultPalette)
        
        XCTAssertEqual(emojiCount, document.defaultPalette.count, "Empty String was wrongly added to palette")
    }
    
    func testAddAndRemoveEmoji_whenTextIsEmoji() throws{
        let emojiCount = document.defaultPalette.count
        
        document.addEmoji("🟢", toPalette: document.defaultPalette)
        XCTAssertEqual(emojiCount+1, document.defaultPalette.count, "Emoji couldn't be added to palette")
        
        document.removeEmojis("🟢", fromPalette: document.defaultPalette)
        XCTAssertEqual(emojiCount, document.defaultPalette.count, "Emoji couldn't be removed from palette")
        
    }
    
    func testRemoveEmoji_onNonExistingEmoji_doesNothing(){
        let emojiCount = document.defaultPalette.count
        
        document.removeEmojis("🔴", fromPalette: document.defaultPalette)
        
        XCTAssertEqual(emojiCount, document.defaultPalette.count)
    }
    
    
    //add emoji to document on any position
    func testAddEmoji_onNewDocument(){
        let documentEmojiCount = document.emojis.count
        
        document.addEmoji("⚽️", at: CGPoint(x: 200, y: 200), size: 2)
        
        XCTAssertEqual(documentEmojiCount+1, document.emojis.count, "Emoji couldn't be added to document")
    }
    
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
