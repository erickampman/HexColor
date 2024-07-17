//
//  ContentView.swift
//  HexColor
//
//  Created by Eric Kampman on 7/16/24.
//

import SwiftUI
import Combine

struct ContentView: View {
	@State private var hexValue = ""				// displayed hex text of color
	@State private var pickerColor = Color.white	// displayed color
	
	// 'color' is intended to be the actual source of truth.
	// In a real project this would likely passed in via a binding.
	@State private var color = Color.white
	
    var body: some View {
        VStack {
			ColorPicker("Color", selection: $pickerColor)
				.onChange(of: pickerColor) {
					let cstr = hexOfColor(pickerColor)
					hexValue = cstr
					color = pickerColor
					NSColorPanel.shared.close()
				}
			TextField("hex number",text: $hexValue)
				.onChange(of: hexValue) {
					let filtered = hexValue.filter {
						"0123456789abcdefABCDEF".contains($0)
					}
					let uc = filtered.lowercased()
					if uc != hexValue {
						self.hexValue = uc
					}
					if ContentView.isValidHexColor(uc) {
						var r = Double(0)
						var g = Double(0)
						var b = Double(0)
						getHexColorComponents(uc, red: &r, green: &g, blue: &b)
						//	getHexColorComponentsOld(uc, red: &r, green: &g, blue: &b)
						let c = Color(red: r, green: g, blue: b)
						if c != color {
							color = c
							pickerColor = color
						}
					}
				}
			Text("0x\(hexValue)")
        }
        .padding()
    }
	
	// not sure this is ok when not ASCII-ish
	static func isValidHexColor(_ str: String) -> Bool {
		let val = str.filter {
			"0123456789abcdefABCDEF".contains($0)
		}
		return val.count == 6
	}
	
	// no preflighting -- be careful
	
}

#Preview {
    ContentView()
}
