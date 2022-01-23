import XCTest

class EmojiArtUITests: XCTestCase {

    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }
    
    //test edit document name with different names
    func testEditDocumentName() throws{
        
        //random document names
        let newNames = ["Test 1", "Apple pie", "New Document", "Penguin", "Comic Drawing"]
        let newDocumentName = newNames.randomElement()
        
        //check if device is ipad
        //if so, go to document chooser
        if(UIDevice.current.userInterfaceIdiom == .pad){
            let documentChooser = app.buttons["Emoji Art"]
            if(documentChooser.exists){
                documentChooser.tap()
            }
        }
        
        //get default document
        let defaultDocument = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(defaultDocument.exists, "Couldn't find default document")
        
        //tap edit
        let navBar = app.navigationBars["Emoji Art"]
        XCTAssertTrue(navBar.exists, "Couldn't find nav bar 'Emoji Art'")
        navBar.buttons["Edit"].tap()
        
        //tap on default document
        defaultDocument.tap()
        
        //get textfield
        let editableTextfield = app.textFields.firstMatch
        XCTAssertTrue(editableTextfield.exists, "Couldn't find editable textfield")
        
        //edit document name
        editableTextfield.tap(withNumberOfTaps: 3, numberOfTouches: 1) //triple tap, to select entire value
        editableTextfield.typeText(newDocumentName!)
        
        //tap done
        navBar.buttons["Done"].tap()
        
        //get new document name
        let updatedDocumentName = defaultDocument.label
        
        //asserts
        XCTAssertEqual(newDocumentName, updatedDocumentName)
        XCTAssertNotEqual("Untitled", updatedDocumentName)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
