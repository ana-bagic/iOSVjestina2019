//
//  UIColor+FlatColors.swift
//  QuizAppFinal
//
//  Created by five on 19/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

extension UIColor {
    struct FlatColor {
        struct Green {
            static let Fern = UIColor(hex: "#6ABB72ff")
            static let MountainMeadow = UIColor(hex: "#3ABB9Dff")
            static let ChateauGreen = UIColor(hex: "#4DA664ff")
            static let PersianGreen = UIColor(hex: "#2CA786ff")
        }
        
        struct Blue {
            static let PictonBlue = UIColor(hex: "#5CADCFff")
            static let Mariner = UIColor(hex: "#3585C5ff")
            static let CuriousBlue = UIColor(hex: "#4590B6ff")
            static let Denim = UIColor(hex: "#2F6CADff")
            static let Chambray = UIColor(hex: "#485675ff")
            static let BlueWhale = UIColor(hex: "#29334Dff")
        }
        
        struct Violet {
            static let Wisteria = UIColor(hex: "#9069B5ff")
            static let BlueGem = UIColor(hex: "#533D7Fff")
        }
        
        struct Yellow {
            static let Energy = UIColor(hex: "#F2D46Fff")
            static let Turbo = UIColor(hex: "#F7C23Eff")
        }
        
        struct Orange {
            static let NeonCarrot = UIColor(hex: "#F79E3Dff")
            static let Sun = UIColor(hex: "#EE7841ff")
        }
        
        struct Red {
            static let TerraCotta = UIColor(hex: "#E66B5Bff")
            static let Valencia = UIColor(hex: "#CC4846ff")
            static let Cinnabar = UIColor(hex: "#DC5047ff")
            static let WellRead = UIColor(hex: "#B33234ff")
        }
        
        struct Gray {
            static let AlmondFrost = UIColor(hex: "#A28F85ff")
            static let WhiteSmoke = UIColor(hex: "#EFEFEFff")
            static let Iron = UIColor(hex: "#D1D5D8ff")
            static let IronGray = UIColor(hex: "#75706Bff")
        }
    }
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
