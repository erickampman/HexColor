//
//  ColorUtil.swift
//  HexColor
//
//  Created by Eric Kampman on 7/16/24.
//

import Foundation
import SwiftUI

func roundFloat(_ f: Float) -> Float {
	let multiplier = Double(1000)
	return Float(((Double(f) * multiplier).rounded() / multiplier))
}

/*
	Converting from [0..256] to [0.0..1.0] and then back
	is rife with conversion problems, so a table is born.
 */
let componentTable: [Float]  = [
	0.0, 0.004, 0.008, 0.012,
	0.016, 0.02, 0.024, 0.027,
	0.031, 0.035,
	// 10
	0.039, 0.043, 0.047, 0.051,
	0.055, 0.059, 0.061, 0.067,
	0.071, 0.075,
	// 20
	0.078, 0.082, 0.086, 0.09,
	0.094, 0.098, 0.102, 0.106,
	0.11, 0.114,
	// 30
	0.118, 0.122, 0.125, 0.129,
	0.133, 0.137, 0.141, 0.145,
	0.149, 0.153,
	// 40
	0.157, 0.161, 0.165, 0.169,
	0.173, 0.176, 0.18, 0.184,
	0.188, 0.192,
	// 50
	0.196, 0.2, 0.204, 0.208,
	0.212, 0.216, 0.22, 0.224,
	0.227, 0.231,
	// 60
	0.235, 0.239, 0.243, 0.247,
	0.251, 0.255, 0.259, 0.263,
	0.267, 0.271,
	// 70
	0.275, 0.278, 0.282, 0.286,
	0.290, 0.294, 0.298, 0.302,
	0.306, 0.31,
	// 80
	0.314, 0.318, 0.322, 0.325,
	0.329, 0.333, 0.337, 0.341,
	0.345, 0.349,
	// 90
	0.353, 0.357, 0.361, 0.365,
	0.369, 0.373, 0.376, 0.38,
	0.384, 0.388,
	// 100
	0.392, 0.396, 0.4, 0.404,
	0.408, 0.412, 0.416, 0.42,
	0.424, 0.427,
	// 110
	0.431, 0.435, 0.439, 0.443,
	0.447, 0.451, 0.455, 0.459,
	0.463, 0.467,
	// 120
	0.471, 0.475, 0.478, 0.482,
	0.486, 0.490, 0.494, 0.498,
	0.502, 0.506,
	// 130
	0.51, 0.514, 0.518, 0.522,
	0.525, 0.529, 0.533, 0.537,
	0.541, 0.545,
	// 140
	0.549, 0.553, 0.557, 0.561,
	0.565, 0.569, 0.573, 0.576,
	0.580, 0.584,
	// 150
	0.588, 0.592, 0.596, 0.6,
	0.604, 0.608, 0.612, 0.616,
	0.62, 0.624,
	// 160
	0.627, 0.631, 0.635, 0.639,
	0.643, 0.647, 0.651, 0.655,
	0.659, 0.663,
	// 170
	0.667, 0.671, 0.675, 0.678,
	0.682, 0.686, 0.690, 0.694,
	0.698, 0.702,
	// 180
	0.706, 0.71, 0.714, 0.718,
	0.722, 0.725, 0.729, 0.733,
	0.737, 0.741,
	// 190
	0.745, 0.749, 0.753, 0.757,
	0.761, 0.765, 0.769, 0.773,
	0.776, 0.780,
	// 200
	0.784, 0.788, 0.792, 0.796,
	0.8, 0.804, 0.808, 0.812,
	0.816, 0.82,
	// 210
	0.824, 0.827, 0.831, 0.835,
	0.839, 0.843, 0.847, 0.851,
	0.855, 0.859,
	// 220
	0.863, 0.867, 0.871, 0.875,
	0.878, 0.882, 0.886, 0.890,
	0.894, 0.898,
	// 230
	0.902, 0.906, 0.91, 0.914,
	0.918, 0.922, 0.925, 0.929,
	0.933, 0.937,
	// 240
	0.941, 0.945, 0.949, 0.953,
	0.957, 0.961, 0.965, 0.969,
	0.973, 0.976,
	// 250
	0.980, 0.984, 0.988, 0.992,
	0.996, 1.0,
]

func colorComponentToInt(_ c: Float) -> Int {
	if c == 0 { return 0 }
	for i in 1..<componentTable.count {
		if c == componentTable[i] {
			return i
		}
		if c < componentTable[i] {
			return i - 1
		}
	}
	return -1
}

func intToColorComponent(_ c: Int) -> Float {
	if c <= 0 { return 0 }
	if c > 255 { return 1.0 }
	return componentTable[c]
}

func getHexColorComponents(_ str: String, red: inout Double, green: inout Double, blue: inout Double) {
	var position = 0
	var index = 0
	var array: [Int] = [0, 0, 0]
	for c in str {
		let v = Int(String(c), radix: 16)!
		index = position / 2
		array[index] = array[index] * 16 + v
		position += 1
	}
	
	red = Double(intToColorComponent(array[0]))
	green = Double(intToColorComponent(array[1]))
	blue = Double(intToColorComponent(array[2]))
//	red = Double(Double(array[0]) / 255.0)
//	green = Double(Double(array[1]) / 255.0)
//	blue = Double(Double(array[2]) / 255.0)
}

func getHexColorComponentsOld(_ str: String, red: inout Double, green: inout Double, blue: inout Double) {
	red = 0
	green = 0
	blue = 0
	
	guard var val = UInt64(str, radix: 16) else { return }	// should have
	if val == 0 								{ return }	// better
	if val >= (16 * 16 * 16 * 16 * 16 * 16 ) 	{ return }	// answer FIXME
	
	let r1 = val / (16 * 16 * 16 * 16 * 16)
	val -= r1 * (16 * 16 * 16 * 16 * 16)
	let r2 = val / (16 * 16 * 16 * 16)
	val -= r2 * (16 * 16 * 16 * 16)

	let g1 = val / (16 * 16 * 16)
	val -= g1 * (16 * 16 * 16)
	let g2 = val / (16 * 16)
	val -= g2 * (16 * 16)

	let b1 = val / 16
	val -= b1 * 16
	let b2 = val
	
	let r = r1 * 16 + r2
	let g = g1 * 16 + g2
	let b = b1 * 16 + b2
	red = Double(r) / 255.0
	green = Double(g) / 255.0
	blue = Double(b) / 255.0
	
	print("r(\(red)) g(\(green)) b(\(blue))")
}

func hexOfColor(_ color: Color) -> String {
//		let multiplier = Float(100000)
	guard let components = NSColor(color).cgColor.components else { return "" }
//	let components = color.resolve(in: environment) // doesn't map right FF becomes FE
	
	let r = roundFloat(Float(components[0]))
	let g = roundFloat(Float(components[1]))
	let b = roundFloat(Float(components[2]))

	let r2 = UInt(colorComponentToInt(r))
	let g2 = UInt(colorComponentToInt(g))
	let b2 = UInt(colorComponentToInt(b))
	
	let rstr = String(format: "%02x%02x%02x", r2, g2, b2)
	return rstr
}
