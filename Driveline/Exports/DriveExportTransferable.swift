//
//  DriveExportTransferable.swift
//  Driveline
//
//  Created by Damien Glancy on 10/06/2026.
//

import CoreTransferable
import Foundation
import UniformTypeIdentifiers

// MARK: - UTType

extension UTType {
  nonisolated static let gpx = UTType(filenameExtension: "gpx", conformingTo: .xml) ?? .xml
}

// MARK: - GPX export

struct DriveGPXExport: Transferable {
  nonisolated(unsafe) let drive: Drive

  static var transferRepresentation: some TransferRepresentation {
    FileRepresentation(exportedContentType: .gpx) { export in
      SentTransferredFile(try await ExportDriveGPX().export(drive: export.drive))
    }
  }
}

// MARK: - PNG export

struct DrivePNGExport: Transferable {
  nonisolated(unsafe) let drive: Drive

  static var transferRepresentation: some TransferRepresentation {
    FileRepresentation(exportedContentType: .png) { export in
      SentTransferredFile(try await ExportDrivePNG().export(drive: export.drive))
    }
  }
}
