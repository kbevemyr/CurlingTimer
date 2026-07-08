//
//  TimeFormat.swift
//  CurlingTimer
//
//  Shared formatting helpers used by both the iOS and watchOS targets,
//  so display logic only has to be maintained in one place.
//

import Foundation

enum TimeFormat {

    /// Formats a duration in milliseconds as seconds with two decimals, e.g. "3.42".
    static func seconds(_ milliseconds: Double) -> String {
        String(format: "%.2f", milliseconds / 1000)
    }

    /// Like `seconds(_:)`, but returns an empty string for unused (zero)
    /// values so that unused log columns stay blank.
    static func loggedSeconds(_ milliseconds: Double) -> String {
        guard milliseconds >= 0.01 else { return "" }
        return seconds(milliseconds)
    }

    // DateFormatter is expensive to create, so build it once.
    private static let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    /// Formats the wall-clock timestamp shown next to each log entry, 24-hour style.
    static func timestamp(_ date: Date) -> String {
        timestampFormatter.string(from: date)
    }
}
