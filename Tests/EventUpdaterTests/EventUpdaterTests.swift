import XCTest
@testable import EventUpdater

class BalanceUpdater: EventUpdater {

    var timer: DispatchSourceTimer?

    var deadline: DispatchTime?

    var timeInterval: TimeInterval = 5

    var expectation: XCTestExpectation?

    var balance: Double = 0

    func eventHandler() {
        balance += 1

        if balance == 2 {
            expectation?.fulfill()
            stopUpdating()
        }
    }
}

final class EventUpdaterTests: XCTestCase {

    func testExample() {
        let expectation = XCTestExpectation()

        let balanceUpdater = BalanceUpdater()
        balanceUpdater.expectation = expectation

        balanceUpdater.startUpdating()

        wait(for: [expectation], timeout: 15)

    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
