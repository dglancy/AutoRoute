//
//  FinishDriveIntent.swift
//  Driveline
//
//  Created by Damien Glancy on 07/06/2026.
//

import AppIntents

struct FinishDriveIntent: LiveActivityIntent {

  static var title: LocalizedStringResource { "Finish drive" }

  func perform() async throws -> some IntentResult {
    .result()
  }
}
