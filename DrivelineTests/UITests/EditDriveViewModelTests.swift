//
//  EditDriveViewModelTests.swift
//  Driveline
//
//  Created by Damien Glancy on 07/06/2026.
//

@testable import Driveline
internal import CoreSpotlight
import Foundation
import Testing

@Suite("EditDriveViewModel")
@MainActor
struct EditDriveViewModelTests {

  // MARK: - Initialisation

  @Test
  func driveNameIsEmptyWhenDriveHasNoUserSetName() {
    let drive = makeDrive(name: nil)
    let vm = buildViewModel(drive: drive)
    #expect(vm.driveName == "")
  }

  @Test
  func driveNameIsUserSetNameWhenPresent() {
    let vm = buildViewModel(drive: makeDrive(name: "My Trip"))
    #expect(vm.driveName == "My Trip")
  }

  @Test
  func startPlaceNameInitialisesFromDrive() {
    let drive = makeDrive(name: nil)
    drive.startPlaceName = "Cork"
    let vm = buildViewModel(drive: drive)
    #expect(vm.startPlaceName == "Cork")
  }

  @Test
  func endPlaceNameInitialisesFromDrive() {
    let drive = makeDrive(name: nil)
    drive.endPlaceName = "Dublin"
    let vm = buildViewModel(drive: drive)
    #expect(vm.endPlaceName == "Dublin")
  }

  // MARK: - save()

  @Test
  func savePreservesUserSetName() {
    let drive = makeDrive(name: nil)
    let vm = buildViewModel(drive: drive)
    vm.driveName = "My Trip"
    vm.save()
    #expect(drive.name == "My Trip")
  }

  @Test
  func saveTrimsWhitespace() {
    let drive = makeDrive(name: nil)
    let vm = buildViewModel(drive: drive)
    vm.driveName = "  Trip  "
    vm.save()
    #expect(drive.name == "Trip")
  }

  @Test
  func saveSetsNameToNilWhenDriveNameIsEmpty() {
    let drive = makeDrive(name: "Old Name")
    let vm = buildViewModel(drive: drive)
    vm.driveName = ""
    vm.save()
    #expect(drive.name == nil)
  }

  @Test
  func saveSetsNameToNilWhenDriveNameIsWhitespaceOnly() {
    let drive = makeDrive(name: "Old Name")
    let vm = buildViewModel(drive: drive)
    vm.driveName = "   "
    vm.save()
    #expect(drive.name == nil)
  }

  @Test
  func savePersistsPlaceNames() {
    let drive = makeDrive(name: nil)
    let vm = buildViewModel(drive: drive)
    vm.startPlaceName = "Cork"
    vm.endPlaceName = "Dublin"
    vm.save()
    #expect(drive.startPlaceName == "Cork")
    #expect(drive.endPlaceName == "Dublin")
  }

  @Test
  func saveIndexesDriveInSpotlight() async {
    let mockSpotlight = MockSpotlightIndex()
    let drive = makeDrive(name: nil)
    let vm = buildViewModel(drive: drive, spotlight: SpotlightIndexingService(index: mockSpotlight))

    vm.driveName = "My Trip"
    vm.save()

    await Task.yield()
    await Task.yield()

    #expect(mockSpotlight.indexedItems.count == 1)
    #expect(mockSpotlight.indexedItems[0].uniqueIdentifier == drive.id.uuidString)
  }

  // MARK: - Helpers

  private func makeDrive(name: String?) -> Drive {
    let drive = Drive(name: name)
    drive.startedAt = Date(timeIntervalSinceReferenceDate: 0)
    drive.endedAt = Date(timeIntervalSinceReferenceDate: 3600)
    return drive
  }

  private func buildViewModel(drive: Drive, spotlight: SpotlightIndexingService = SpotlightIndexingService(index: MockSpotlightIndex())) -> EditDriveViewModel {
    EditDriveViewModel(drive: drive, spotlightIndexingService: spotlight)
  }
}
