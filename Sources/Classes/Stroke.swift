//
//  Stroke.swift
//  Pixel-iOS
//
//  Created by José Donor on 28/11/2018.
//


public struct Stroke: Equatable, Codable {

	public enum Alignment: String, Codable {
		case out
		case center
		case `in`
	}


	public var width: CGFloat
	public var cap: CGLineCap
	public var join: CGLineJoin
	public var dash: CGFloat
	public var gap: CGFloat
	public var phase: CGFloat
	public var alignment: Alignment


	// MARK: - Initialize

	public init() {
		self .init(width: 1)
	}

	public init(width: CGFloat = 1,
				cap: CGLineCap = .round,
				join: CGLineJoin = .round,
				dash: CGFloat = 0,
				gap: CGFloat = 0,
				phase: CGFloat = 0,
				alignment: Alignment = .center) {

		self.width = width
		self.cap = cap
		self.join = join
		self.dash = dash
		self.gap = gap
		self.phase = phase
		self.alignment = alignment

	}


	// MARK: - Drawing

	/// Applies Gradient on a CGContext
	public func draw(context: CGContext) {

		context.setLineWidth(width)
		context.setLineCap(cap)
		context.setLineJoin(join)

		if gap > 0 {
			context.setLineDash(phase: phase, lengths: [dash, gap])
		}

	}

}