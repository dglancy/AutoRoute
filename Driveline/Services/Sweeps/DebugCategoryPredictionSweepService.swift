//
//  DebugCategoryPredictionSweepService.swift
//  Driveline
//
//  Created by Damien Glancy on 13/06/2026.
//

import Foundation
import SwiftData

// TODO: Remove this sweep once the DriveCategoryClassifier model is production-ready.
@MainActor
@Observable
final class DebugCategoryPredictionSweepService: SweepServiceProtocol {

  // MARK: - Properties

  @ObservationIgnored private let modelContext: ModelContext
  @ObservationIgnored private let classifierService: any DriveClassifierServiceProtocol
  nonisolated var taskIdentifier: String { Constants.Configuration.debugCategoryPredictionSweepTaskIdentifier }

  // MARK: - Lifecycle

  init(modelContext: ModelContext, classifierService: any DriveClassifierServiceProtocol) {
    self.modelContext = modelContext
    self.classifierService = classifierService
  }

  // MARK: - Actions

  func sweep() async {
    let descriptor = FetchDescriptor<Drive>()
    guard let drives = try? modelContext.fetch(descriptor) else { return }
    let finished = drives.filter { $0.status == .finished }

    for drive in finished {
      guard !Task.isCancelled else { return }
      await classifierService.classify(drive)
    }
  }
}
