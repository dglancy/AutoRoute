//
//  GlassButton.swift
//  Driveline
//
//  Created by Damien Glancy on 31/05/2026.
//

import SwiftUI

struct GlassButton: View {

  // MARK: - Properties

  let systemImage: String
  let accessibilityLabel: LocalizedStringResource
  let action: () -> Void

  // MARK: - Body

  var body: some View {
    Button(action: action) {
      Image(systemName: systemImage)
        .font(.callout.weight(.semibold))
        .foregroundStyle(.primary)
        .frame(width: 18, height: 18)
        .dynamicTypeSize(.xSmall ... .accessibility1)
    }
    .buttonStyle(.glass)
    .buttonBorderShape(.circle)
    .accessibilityLabel(Text(accessibilityLabel))
  }
}
