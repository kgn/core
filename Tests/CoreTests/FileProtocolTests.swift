import Foundation
import XCTest

@testable import Core

class FileProtocolTests: XCTestCase {
    static let allTests = [
        ("testLoad", testLoad),
        ("testLoadFail", testLoadFail),
        ("testSave", testSave),
    ]

    func testLoad() throws {
        let file = DataFile()
        let bytes = try file.load(path: #file)
        XCTAssert(bytes.string.contains("foobar")) // inception
    }

    func testLoadFail() throws {
        let path = "!!!ferret!!!"

        do {
            _ = try DataFile.load(path: path)
            XCTFail("Shouldn't have loaded")
        } catch DataFile.Error.load {
            // ok
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testSave() throws {
        let writeableDir = #file.components(separatedBy: "/").dropLast().joined(separator: "/")
        let filePath = writeableDir + "/testfile.text"
        do {
            _ = try DataFile.load(path: filePath)
            var message = "Filepath shouldn't already exist, a previous test likely failed."
            message += "\nDelete the file at `\(filePath)` before continuing ..."
            XCTFail(message)
            return
        } catch DataFile.Error.load {
            // ok
        } // will throw other errors here

        let create = "TEST FILE --- DELETE IF FOUND"
        try DataFile.save(bytes: create.makeBytes(), to: filePath)
        let createRecovered = try DataFile.load(path: filePath)
        XCTAssertEqual(create, createRecovered.string)

        let overwrite = "new contents test ... TEST FILE --- DELETE IF FOUND"
        try DataFile.save(bytes: overwrite.makeBytes(), to: filePath)
        let overwriteRecovered = try DataFile.load(path: filePath)
        XCTAssertEqual(overwrite, overwriteRecovered.string)

        try DataFile.delete(at: filePath)
    }
}
