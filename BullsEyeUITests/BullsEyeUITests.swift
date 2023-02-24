/// Copyright (c) 2021. Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest

class BullsEyeUITests: XCTestCase {
  var app: XCUIApplication!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }
  
  func testGameStyleSwitch() {
    // given
    let slideButton = app.segmentedControls.buttons["Slide"]
    let typeButton = app.segmentedControls.buttons["Type"]
    let slideLabel = app.staticTexts["Get as close as you can to: "]
    let typeLabel = app.staticTexts["Guess where the slider is: "]
    
    // then
    if slideButton.isSelected {
      XCTAssertTrue(slideLabel.exists)
      XCTAssertFalse(typeLabel.exists)

      typeButton.tap()
      XCTAssertTrue(typeLabel.exists)
      XCTAssertFalse(slideLabel.exists)
    } else if typeButton.isSelected {
      XCTAssertTrue(typeLabel.exists)
      XCTAssertFalse(slideLabel.exists)

      slideButton.tap()
      XCTAssertTrue(slideLabel.exists)
      XCTAssertFalse(typeLabel.exists)
    }
  }
  
  func testComplexTest() {
    app.buttons["start over"].tap()
    
    attachScreenshot(with: "Start over tapped")
    
    let slideButton = app.segmentedControls.buttons["Slide"]
    if slideButton.isSelected == false {
      slideButton.tap()
      
      attachScreenshot(with: "Slide button tapped")
      
      XCTAssertTrue(slideButton.isSelected)
    }
    
    app.sliders["Main Slider"].adjust(toNormalizedSliderPosition: 0.9)
    
    attachScreenshot(with: "Slider adjusted")
    
    app.buttons["hit me!"].tap()
    
    attachScreenshot(with: "Hit me tapped")
    
    let okButton = app.alerts.element.buttons["OK"];
    
    attachScreenshot(with: "Alert appeared")
    
    XCTAssertTrue(okButton.exists)
    
    okButton.tap()
    
    attachScreenshot(with: "Alert closed")
    
    XCTAssertFalse(okButton.exists)
  }
  
  func testContiniousScreenshotting() {
    let timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
      let unixTime = Date.timeIntervalBetween1970AndReferenceDate
      self.attachScreenshot(with: "\(unixTime)")
    }
    timer.fire()
    
    app.buttons["start over"].tap()
        
    let slideButton = app.segmentedControls.buttons["Slide"]
    if slideButton.isSelected == false {
      slideButton.tap()
      
      XCTAssertTrue(slideButton.isSelected)
    }
    
    app.sliders["Main Slider"].adjust(toNormalizedSliderPosition: 0.9)
    
    app.buttons["hit me!"].tap()
    
    let okButton = app.alerts.element.buttons["OK"];
    
    XCTAssertTrue(okButton.exists)
    
    okButton.tap()
    
    XCTAssertFalse(okButton.exists)
    
    timer.invalidate()
  }
  
  func attachScreenshot(with message: String) {
    let fullScreenshot = XCUIScreen.main.screenshot()
        
        let screenshotAttachment = XCTAttachment(
            uniformTypeIdentifier: "public.png",
            name: "Screenshot-\(UIDevice.current.name)-\(name)-\(message).png",
            payload: fullScreenshot.pngRepresentation,
            userInfo: nil)
            
        // Usually Xcode will delete attachments after
        // the test has run; we don't want that!
        screenshotAttachment.lifetime = .keepAlways
        
        // Add the attachment to the test log,
        // so we can retrieve it later
        add(screenshotAttachment)
  }
}

class BullsEyeUITests2: XCTestCase {
  var app: XCUIApplication!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }
  
  func testGameStyleSwitch() {
    // given
    let slideButton = app.segmentedControls.buttons["Slide"]
    let typeButton = app.segmentedControls.buttons["Type"]
    let slideLabel = app.staticTexts["Get as close as you can to: "]
    let typeLabel = app.staticTexts["Guess where the slider is: "]
    
    // then
    if slideButton.isSelected {
      XCTAssertTrue(slideLabel.exists)
      XCTAssertFalse(typeLabel.exists)

      typeButton.tap()
      XCTAssertTrue(typeLabel.exists)
      XCTAssertFalse(slideLabel.exists)
    } else if typeButton.isSelected {
      XCTAssertTrue(typeLabel.exists)
      XCTAssertFalse(slideLabel.exists)

      slideButton.tap()
      XCTAssertTrue(slideLabel.exists)
      XCTAssertFalse(typeLabel.exists)
    }
  }
}
