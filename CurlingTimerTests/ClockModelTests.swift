//
//  ClockModelTests.swift
//  CurlingTimerTests
//
//  Unit tests for the timing calculations in Clock and the shared
//  formatting helpers in TimeFormat.
//

import XCTest

final class ClockModelTests: XCTestCase {

    // MARK: - Conversion factors

    func testTeeAndBackConversionsAreExactInverses() {
        let clock = Clock()
        let teeTime = 3500.0

        let backTime = clock.calcBackTime(tee: teeTime)
        let roundTripped = clock.calcTeeTime(back: backTime)

        XCTAssertEqual(roundTripped, teeTime, accuracy: 0.000_001)
    }

    func testBackTimeIsLongerThanTeeTime() {
        let clock = Clock()
        XCTAssertGreaterThan(clock.calcBackTime(tee: 3500), 3500)
        XCTAssertLessThan(clock.calcTeeTime(back: 3500), 3500)
    }

    // MARK: - getTime per timing strategy

    func testGetTimeForTeeStrategy() {
        let clock = Clock()
        clock.timingLine = .tee
        clock.t_end = 3500

        let result = clock.getTime()

        XCTAssertEqual(result.tee, 3500)
        XCTAssertEqual(result.back, 3500 * Clock.backToTeeTimeRatio, accuracy: 0.000_001)
        XCTAssertEqual(result.hoghog, 0)
    }

    func testGetTimeForBackStrategy() {
        let clock = Clock()
        clock.timingLine = .back
        clock.t_end = 4396

        let result = clock.getTime()

        XCTAssertEqual(result.back, 4396)
        XCTAssertEqual(result.tee, 4396 / Clock.backToTeeTimeRatio, accuracy: 0.000_001)
        XCTAssertEqual(result.hoghog, 0)
    }

    func testGetTimeForHogHogStrategy() {
        let clock = Clock()
        clock.timingLine = .hoghog
        clock.t_end = 14200

        let result = clock.getTime()

        XCTAssertEqual(result.tee, 0)
        XCTAssertEqual(result.back, 0)
        XCTAssertEqual(result.hoghog, 14200)
    }

    // MARK: - Timing

    func testStopTimeMeasuresElapsedTimeIndependentlyOfUpdateTime() {
        let clock = Clock()
        clock.initTime()
        // Deliberately no updateTime() calls: stopTime must measure on its own.
        Thread.sleep(forTimeInterval: 0.1)
        clock.stopTime()

        XCTAssertGreaterThanOrEqual(clock.t_end, 90, "expected at least ~100 ms elapsed")
        XCTAssertLessThan(clock.t_end, 1000, "unreasonably long elapsed time")
        XCTAssertEqual(clock.currentTime, clock.t_end)
    }

    func testInitTimeResetsState() {
        let clock = Clock()
        clock.t_end = 1234
        clock.currentTime = 1234

        clock.initTime()

        XCTAssertEqual(clock.t_end, 0)
        XCTAssertEqual(clock.currentTime, 0)
    }

    // MARK: - Log

    func testLogAddAndClear() {
        var log = Log()
        log.addPost(post: LogItem(id: 0, when: Date(), bakkant: 1, tee: 2, hoghog: 0))
        log.addPost(post: LogItem(id: 1, when: Date(), bakkant: 3, tee: 4, hoghog: 0))

        XCTAssertEqual(log.items.count, 2)
        XCTAssertEqual(log.postcounter, 2)

        log.clearLog()

        XCTAssertTrue(log.items.isEmpty)
        XCTAssertEqual(log.postcounter, 0)
    }

    // MARK: - Formatting

    func testSecondsFormatting() {
        XCTAssertEqual(TimeFormat.seconds(3456), "3.46")
        XCTAssertEqual(TimeFormat.seconds(0), "0.00")
    }

    func testLoggedSecondsHidesUnusedValues() {
        XCTAssertEqual(TimeFormat.loggedSeconds(0), "")
        XCTAssertEqual(TimeFormat.loggedSeconds(3456), "3.46")
    }

    func testTimestampUses24HourClock() {
        var components = DateComponents()
        components.year = 2026
        components.month = 7
        components.day = 8
        components.hour = 14
        components.minute = 32
        components.second = 5
        let date = Calendar.current.date(from: components)!

        XCTAssertEqual(TimeFormat.timestamp(date), "14:32:05")
    }
}
