import Foundation
import XCTest
@testable import Core

class UtilityTests: XCTestCase {

    static var allTests = [
        ("testLowercase", testLowercase),
        ("testUppercase", testUppercase),
        ("testIntHex", testIntHex),
    ]

    func testLowercase() {
        let test = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()"

        XCTAssertEqual(
            test.makeBytes().lowercased.string,
            test.lowercased(),
            "Data utility did not match Foundation"
        )
    }

    func testUppercase() {
        let test = "abcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()"

        XCTAssertEqual(
            test.makeBytes().uppercased.string,
            test.uppercased(),
            "Data utility did not match Foundation"
        )
    }

    func testIntHex() {
        let signedHex = (-255).hex
        XCTAssertEqual(signedHex, "-FF")

        let unsignedHex = Byte(125).hex
        XCTAssertEqual(unsignedHex, "7D")
    }
}
