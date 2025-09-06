//
//  SemanticColors.swift
//  Weather
//
//  Created by 김건혜 on 9/5/25.
//

import SwiftUI

extension Color {
    // MARK: - Background Colors
    static let backgroundPrimary = ColorPalette.gray0
    static let backgroundSecondary = ColorPalette.gray5
    
    // MARK: - Surface Colors
    static let surfacePrimary = ColorPalette.blue5
    static let surfaceSecondary = ColorPalette.yellow20
    static let surfaceTertiary = ColorPalette.gray40
    static let surfaceInverse = ColorPalette.gray10
    static let surfaceSafe = ColorPalette.green30
    static let surfaceWarn = ColorPalette.yellow40
    static let surfaceDanger = ColorPalette.red30
    
    // MARK: - Text Colors
    static let textPrimary = ColorPalette.blue80
    static let textSecondary = ColorPalette.gray80
    static let textTertiary = ColorPalette.gray60
    static let textInverse = ColorPalette.gray0
    static let textSafe = ColorPalette.green60
    static let textWarn = ColorPalette.yellow60
    static let textDanger = ColorPalette.red60
    
    // MARK: - Button Colors
    static let buttonPrimary = ColorPalette.blue50
    static let buttonSecondary = ColorPalette.gray70
    static let buttonTertiary = ColorPalette.gray50
    static let buttonInverse = ColorPalette.gray10
    static let buttonSafe = ColorPalette.green50
    static let buttonWarn = ColorPalette.yellow50
    static let buttonDanger = ColorPalette.red50
    
    // MARK: - Border Colors
    static let borderPrimary = ColorPalette.blue40
    static let borderSecondary = ColorPalette.gray80
    static let borderTertiary = ColorPalette.gray60
    static let borderInverse = ColorPalette.gray10
    static let borderSafe = ColorPalette.green60
    static let borderWarn = ColorPalette.yellow60
    static let borderDanger = ColorPalette.red60
}

// MARK: - ShapeStyle Extension
extension ShapeStyle where Self == Color {
    // MARK: - Background Colors
    static var backgroundPrimary: Color { Color.backgroundPrimary }
    static var backgroundSecondary: Color { Color.backgroundSecondary }
    
    // MARK: - Surface Colors
    static var surfacePrimary: Color { Color.surfacePrimary }
    static var surfaceSecondary: Color { Color.surfaceSecondary }
    static var surfaceTertiary: Color { Color.surfaceTertiary }
    static var surfaceInverse: Color { Color.surfaceInverse }
    static var surfaceSafe: Color { Color.surfaceSafe }
    static var surfaceWarn: Color { Color.surfaceWarn }
    static var surfaceDanger: Color { Color.surfaceDanger }
    
    // MARK: - Text Colors
    static var textPrimary: Color { Color.textPrimary }
    static var textSecondary: Color { Color.textSecondary }
    static var textTertiary: Color { Color.textTertiary }
    static var textInverse: Color { Color.textInverse }
    static var textSafe: Color { Color.textSafe }
    static var textWarn: Color { Color.textWarn }
    static var textDanger: Color { Color.textDanger }
    
    // MARK: - Button Colors
    static var buttonPrimary: Color { Color.buttonPrimary }
    static var buttonSecondary: Color { Color.buttonSecondary }
    static var buttonTertiary: Color { Color.buttonTertiary }
    static var buttonInverse: Color { Color.buttonInverse }
    static var buttonSafe: Color { Color.buttonSafe }
    static var buttonWarn: Color { Color.buttonWarn }
    static var buttonDanger: Color { Color.buttonDanger }
    
    // MARK: - Border Colors
    static var borderPrimary: Color { Color.borderPrimary }
    static var borderSecondary: Color { Color.borderSecondary }
    static var borderTertiary: Color { Color.borderTertiary }
    static var borderInverse: Color { Color.borderInverse }
    static var borderSafe: Color { Color.borderSafe }
    static var borderWarn: Color { Color.borderWarn }
    static var borderDanger: Color { Color.borderDanger }
}
