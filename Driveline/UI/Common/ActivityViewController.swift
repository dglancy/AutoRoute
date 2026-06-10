//
//  ActivityViewController.swift
//  Driveline
//
//  Created by Damien Glancy on 01/06/2026.
//

import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {

  // MARK: - Properties

  let activityItems: [Any]
  var onComplete: (() -> Void)?

  // MARK: - UIViewControllerRepresentable

  func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    controller.completionWithItemsHandler = { _, _, _, _ in
      onComplete?()
    }
    return controller
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
