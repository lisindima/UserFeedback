import XCTest
@testable import UserFeedback

final class UserFeedbackTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(UserFeedback().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
