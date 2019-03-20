//
//  ColorConvertible.swift
//  Pixel-iOS
//
//  Created by José Donor on 20/03/2019.
//


public protocol ColorConvertible {

    /// Color
	var color: Color { get }

}


extension Color: ColorConvertible {

    /// Color
    public var color: Color {
        return self
    }

}
