//
//  UIBezierPath.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//

// Source : https://github.com/ImJCabus/UIBezierPath-Superpowers



extension UIBezierPath {

	/// Enables caching for UIBezierPath.
	///
	/// Internaly caches points, lengths and path components which are all kept when
	/// UIBezierPath is mutated with `addLine`, `addCurve`, `append`...
	public static func enableCaching() {

		guard !swizzled else { return }
		swizzled = true

		let swizzlingPairs: [(Selector, Selector)] = [
			(#selector(UIBezierPath.addLine), #selector(UIBezierPath.mx_addLine)),
			(#selector(UIBezierPath.addCurve), #selector(UIBezierPath.mx_addCurve)),
			(#selector(UIBezierPath.addQuadCurve ), #selector(UIBezierPath.mx_addQuadCurve)),
			(#selector(UIBezierPath.addArc), #selector(UIBezierPath.mx_addArc)),
			(#selector(UIBezierPath.close), #selector(UIBezierPath.mx_close)),
			(#selector(UIBezierPath.removeAllPoints), #selector(UIBezierPath.mx_removeAllPoints)),
			(#selector(UIBezierPath.append), #selector(UIBezierPath.mx_append)),
			(#selector(UIBezierPath.apply), #selector(UIBezierPath.mx_apply))
		]

		swizzlingPairs.forEach {
			swizzle(self, $0.0, $0.1)
		}

	}


	/// Length of UIBezierPath
	///
	/// - Warning: Expensive task, use caching if called multiple times.
	public var length: CGFloat {
		let length = calculateLength()
		if !swizzled { invalidatePathCalculations() }
		return length
	}


	/// Gets the point on path at t in [0, 1]
	///
	/// - Warning: Expensive task, use caching if called multiple times.
	public func point(t: CGFloat) -> CGPoint {

		guard !isEmpty else { return .zero }

		var point: CGPoint = .zero

		findPathElement(at: t) { element, t in
			point = element.point(at: t)
		}

		if !swizzled { invalidatePathCalculations() }

		return point
	}


	/// Gets the slope on path at t in [0, 1]
	///
	/// Y-axis is upside-down, so a value of 1 means that the slope is going down.
	///
	/// - Warning: Expensive task, use caching if called multiple times.
	public func slope(t: CGFloat) -> CGFloat {

		guard !isEmpty else { return 0 }

		var slope: CGFloat = 0

		findPathElement(at: t) { element, t in
			slope = element.slope(at: t)
		}

		if !swizzled { invalidatePathCalculations() }

		//  Returning -slope, because the y-axis of the iOS coordinate system is inverse.
		//  By default, positive slopes would go down, negative go up. This is counter intuitive.
		return -slope
	}


	/// Gets the angle from x-axis to the tangent of the path at t in [0, 1]
	///
	/// - Warning: Expensive task, use caching if called multiple times.
	public func tangentAngle(t: CGFloat) -> CGFloat {

		guard !isEmpty else { return 0 }

		var angle: CGFloat = 0

		findPathElement(at: t) { element, t in
			angle = element.tangentAngle(at: t)
		}

		if !swizzled { invalidatePathCalculations() }

		//  Rotating by .pi / 2, because the y-axis of the iOS coordinate system is inversed.
		//  Smaller values are at the top, increasing to the bottom. This is invers to the
		//  cartesian coordinate system.
		return angle - .pi / 2
	}


	/// Gets closest point on path
	///
	/// - Warning: Expensive task, use caching if called multiple times.
	public func closestPoint(from point: CGPoint) -> CGPoint {

		calculatePointLookupTable()

		var closestPoint: (p: CGPoint, distance: CGFloat) = (.zero, .greatestFiniteMagnitude)

		for element in extractPathElements() {
			if let lookupTable = element.pointsLookupTable {
				for p in lookupTable {
					let distance = (point - p).norm

					if distance < closestPoint.distance {
						closestPoint = (p, distance)
					}
				}
			}
		}

		if !swizzled { invalidatePathCalculations() }

		return closestPoint.p
	}


	/// Calculates shortest distance from point to path
	///
	/// - Warning: Expensive task, use caching if called multiple times.
	public func shortestDistance(to point: CGPoint) -> CGFloat {
		let closestPathPoint = closestPoint(from: point)
		return (closestPathPoint - point).norm
	}

}



// MARK: - Private BezierPathElement

private struct BezierPathElement {

	let type: CGPathElementType

	var startPoint: CGPoint
	var endPoint: CGPoint
	var controlPoints: [CGPoint]

	var pointsLookupTable: [CGPoint]?

	var lengthRange: ClosedRange<CGFloat>?

	private let calculatedLength: CGFloat
	var length: CGFloat {
		return calculatedLength == 0 ? 1 : calculatedLength
	}


	init(type: CGPathElementType, startPoint: CGPoint, endPoint: CGPoint, controlPoints: [CGPoint] = []) {
		self.type = type
		self.startPoint = startPoint
		self.endPoint = endPoint
		self.controlPoints = controlPoints

		calculatedLength = type.calculateLength(from: startPoint, to: endPoint, controlPoints: controlPoints)
	}


	func point(at t: CGFloat) -> CGPoint {
		switch type {
		case .addLineToPoint:
			return startPoint + (endPoint - startPoint) * t
		case .addQuadCurveToPoint:
			return startPoint.quadBezierPoint(to: endPoint, controlPoint: controlPoints[0], t: t)
		case .addCurveToPoint:
			return startPoint.cubicBezierPoint(to: endPoint, controlPoint1: controlPoints[0], controlPoint2: controlPoints[1], t: t)
		default:
			return .zero
		}
	}

	func slope(at t: CGFloat) -> CGFloat {
		switch type {
		case .addLineToPoint:
			let vector = endPoint - startPoint
			return vector.y / vector.x
		case .addQuadCurveToPoint:
			return startPoint.quadSlope(to: endPoint, controlPoint: controlPoints[0], t: t)
		case .addCurveToPoint:
			return startPoint.cubicSlope(to: endPoint, controlPoint1: controlPoints[0], controlPoint2: controlPoints[1], t: t)
		default:
			return 0
		}
	}

	func tangentAngle(at t: CGFloat) -> CGFloat {
		switch type {
		case .addLineToPoint:
			let vector = endPoint - startPoint
			return atan2(vector.x, vector.x)
		case .addQuadCurveToPoint:
			return startPoint.quadTangentAngle(to: endPoint, controlPoint: controlPoints[0], t: t)
		case .addCurveToPoint:
			return startPoint.cubicTangentAngle(to: endPoint, controlPoint1: controlPoints[0], controlPoint2: controlPoints[1], t: t)
		default:
			return 0
		}
	}

	mutating func apply(transform t: CGAffineTransform) {
		guard t.isTranslationOnly else { return }

		startPoint = startPoint.applying(t)
		endPoint = endPoint.applying(t)
		controlPoints = controlPoints.map { $0.applying(t) }
	}

}



// MARK: - UIBezierPath Private Methods

extension UIBezierPath {

	fileprivate func extractPathElements() -> [BezierPathElement] {

		if let pathElements = self.mx_pathElements {
			return pathElements
		}

		var pathElements: [BezierPathElement] = []

		var currentPoint: CGPoint = .zero

		cgPath.apply { element in

			let type = element.type
			let points = element.mx_points

			var endPoint: CGPoint = .zero
			var controlPoints: [CGPoint] = []

			switch type {
			case .moveToPoint, .addLineToPoint:
				endPoint = points[0]
			case .addQuadCurveToPoint:
				endPoint = points[1]
				controlPoints.append(points[0])
			case .addCurveToPoint:
				endPoint = points[2]
				controlPoints.append(contentsOf: points[0...1])
			case .closeSubpath:
				break
			}

			if type != .closeSubpath && type != .moveToPoint {

				let pathElement = BezierPathElement(type: type, startPoint: currentPoint, endPoint: endPoint, controlPoints: controlPoints)

				pathElements.append(pathElement)
			}

			currentPoint = endPoint
		}

		self.mx_pathElements = pathElements

		return pathElements
	}

	fileprivate func findPathElement(at t: CGFloat,
									 callback: (_ e: BezierPathElement, _ t: CGFloat) -> Void) {

		let t = min(max(0, t), 1)

		calculateLengthRanges()

		for element in extractPathElements() {
			if let lengthRange = element.lengthRange, lengthRange.contains(t) {
				let tInElement = (t - lengthRange.lowerBound) / (lengthRange.upperBound - lengthRange.lowerBound)
				callback(element, tInElement)
				break
			}
		}

	}

	fileprivate func calculateLength() -> CGFloat {

		if let length = self.mx_pathLength {
			return length
		}

		let pathElements = extractPathElements()
		let length = pathElements.reduce(0) { $0 + $1.length }

		self.mx_pathLength = length

		return length
	}

	fileprivate func calculateLengthRanges() {

		if mx_lengthRangesCalculated { return }

		var pathElements = extractPathElements()

		let totalPathLength = calculateLength()

		var lengthRangeStart: CGFloat = 0

		for idx in pathElements.indices {
			let elementLength = pathElements[idx].length
			var lengthRangeEnd = lengthRangeStart + elementLength / totalPathLength

			// Sometimes, the last path element will end at 0.9999999999999xx.
			// The math is correct, seems to be an issue with floating point calculations.
			if idx == pathElements.count - 1 {
				lengthRangeEnd = 1
			}

			pathElements[idx].lengthRange = lengthRangeStart...lengthRangeEnd

			lengthRangeStart = lengthRangeEnd
		}

		mx_pathElements = pathElements
		mx_lengthRangesCalculated = true
	}

	fileprivate func calculatePointLookupTable() {

		if mx_pointLookupTableCalculated { return }

		var pathElements = extractPathElements()

		//  Step through all path elements and calculate points.
		//  The start and end point of the whole path are always included.
		let step: CGFloat = 2.5
		var offset: CGFloat = 0

		for idx in pathElements.indices {

			var element = pathElements[idx]
			var points: [CGPoint] = []

			while offset < element.length {
				points.append(element.point(at: offset / element.length))
				offset += step
			}

			if idx == pathElements.count - 1 && offset - step < element.length {
				points.append(element.point(at: 1))
			}

			offset -= element.length

			if points.isEmpty {
				points.append(element.point(at: 0.5))
			}

			element.pointsLookupTable = points

			pathElements[idx] = element
		}

		mx_pathElements = pathElements
		mx_pointLookupTableCalculated = true
	}

}



// MARK: - UIBezierPath Private Properties

private var pathElementsKey = "mx_pathElements_key"
private var pathLengthKey = "mx_pathLength_key"
private var pathElementsLengthRangesCalculated = "mx_pathElementsLengthRangesCalculated_key"
private var pathElementsPointLookupTableCalculated = "mx_pathElementsPointLookupTableCalculated_key"


extension UIBezierPath {

	fileprivate var mx_pathElements: [BezierPathElement]? {
		get {
			return objc_getAssociatedObject(self, &pathElementsKey) as? [BezierPathElement]
		}
		set {
			objc_setAssociatedObject(self, &pathElementsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	fileprivate var mx_pathLength: CGFloat? {
		get {
			return objc_getAssociatedObject(self, &pathLengthKey) as? CGFloat
		}
		set {
			objc_setAssociatedObject(self, &pathLengthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	fileprivate var mx_lengthRangesCalculated: Bool {
		get {
			return objc_getAssociatedObject(self, &pathElementsLengthRangesCalculated) as? Bool ?? false
		}
		set {
			objc_setAssociatedObject(self, &pathElementsLengthRangesCalculated, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	fileprivate var mx_pointLookupTableCalculated: Bool {
		get {
			return objc_getAssociatedObject(self, &pathElementsPointLookupTableCalculated) as? Bool ?? false
		}
		set {
			objc_setAssociatedObject(self, &pathElementsPointLookupTableCalculated, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	fileprivate func invalidatePathCalculations() {
		mx_pathElements = nil
		mx_pathLength = nil
		mx_lengthRangesCalculated = false
		mx_pointLookupTableCalculated = false
	}

}



// MARK: - Swizzling

private var swizzled = false

private func swizzle(_ c: AnyClass, _ originalSelector: Selector, _ swizzledSelector: Selector) {

	guard let originalMethod = class_getInstanceMethod(c, originalSelector),
		let swizzledMethod = class_getInstanceMethod(c, swizzledSelector)
		else { return }

	method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension UIBezierPath {

	@objc
	fileprivate func mx_addLine(to point: CGPoint) {
		mx_addLine(to: point)
		invalidatePathCalculations()
	}

	@objc
	fileprivate func mx_addCurve(to endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
		mx_addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
		invalidatePathCalculations()
	}

	@objc
	fileprivate func mx_addQuadCurve(to endPoint: CGPoint, controlPoint: CGPoint) {
		mx_addQuadCurve(to: endPoint, controlPoint: controlPoint)
		invalidatePathCalculations()
	}

	@objc
	fileprivate func mx_addArc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
		mx_addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
		invalidatePathCalculations()
	}

	@objc
	fileprivate func mx_close() {
		mx_close()
		invalidatePathCalculations()
	}

	@objc
	fileprivate func mx_removeAllPoints() {
		mx_removeAllPoints()
		invalidatePathCalculations()
	}

	@objc
	fileprivate func mx_append(path: UIBezierPath) {
		mx_append(path: path)
		invalidatePathCalculations()
	}

	@objc
	fileprivate func mx_apply(t: CGAffineTransform) {
		mx_apply(t: t)
		if t.isTranslationOnly {
			mx_pathElements?.indices.forEach { mx_pathElements?[$0].apply(transform: t) }
		} else {
			invalidatePathCalculations()
		}
	}
}



// MARK: - CGPoint Helpers

extension CGPoint {

	fileprivate func quadCurveLength(to: CGPoint,
									 controlPoint c: CGPoint) -> CGFloat {

		let roughLength = (c - self).norm + (to - c).norm
		let iterations = Int(roughLength * 0.4)

		var length: CGFloat = 0

		for idx in 0..<iterations {
			let t = CGFloat(idx) / CGFloat(iterations)
			let tt = t + (1 / CGFloat(iterations))

			let p = self.quadBezierPoint(to: to, controlPoint: c, t: t)
			let pp = self.quadBezierPoint(to: to, controlPoint: c, t: tt)

			length += (pp - p).norm
		}

		return length
	}

	fileprivate func quadBezierPoint(to: CGPoint,
									 controlPoint: CGPoint,
									 t: CGFloat) -> CGPoint {

		let x = _quadBezier(t, self.x, controlPoint.x, to.x)
		let y = _quadBezier(t, self.y, controlPoint.y, to.y)

		return CGPoint(x: x, y: y)
	}

	fileprivate func quadSlope(to: CGPoint,
							   controlPoint: CGPoint,
							   t: CGFloat) -> CGFloat {

		let dx = _quadSlope(t, self.x, controlPoint.x, to.x)
		let dy = _quadSlope(t, self.y, controlPoint.y, to.y)

		return dy / dx
	}

	fileprivate func quadTangentAngle(to: CGPoint,
									  controlPoint: CGPoint,
									  t: CGFloat) -> CGFloat {

		let dx = _quadSlope(t, self.x, controlPoint.x, to.x)
		let dy = _quadSlope(t, self.y, controlPoint.y, to.y)

		return atan2(dx, dy)
	}

	fileprivate func cubicCurveLength(to: CGPoint,
									  controlPoint1 c1: CGPoint,
									  controlPoint2 c2: CGPoint) -> CGFloat {

		let roughLength = (c1 - self).norm + (c2 - c1).norm + (to - c2).norm
		let iterations = Int(roughLength * 0.4)

		var length: CGFloat = 0

		for idx in 0..<iterations {
			let t = CGFloat(idx) * (1 / CGFloat(iterations))
			let tt = t + (1 / CGFloat(iterations))

			let p = self.cubicBezierPoint(to: to, controlPoint1: c1, controlPoint2: c2, t: t)
			let pp = self.cubicBezierPoint(to: to, controlPoint1: c1, controlPoint2: c2, t: tt)

			length += (pp - p).norm
		}

		return length
	}

	fileprivate func cubicBezierPoint(to: CGPoint,
									  controlPoint1 c1: CGPoint,
									  controlPoint2 c2: CGPoint, t: CGFloat) -> CGPoint {

		let x = _cubicBezier(t, self.x, c1.x, c2.x, to.x)
		let y = _cubicBezier(t, self.y, c1.y, c2.y, to.y)

		return CGPoint(x: x, y: y)
	}

	fileprivate func cubicSlope(to: CGPoint,
								controlPoint1 c1: CGPoint,
								controlPoint2 c2: CGPoint, t: CGFloat) -> CGFloat {

		let dx = _cubicSlope(t, self.x, c1.x, c2.x, to.x)
		let dy = _cubicSlope(t, self.y, c1.y, c2.y, to.y)

		return dy / dx
	}

	fileprivate func cubicTangentAngle(to: CGPoint,
									   controlPoint1 c1: CGPoint,
									   controlPoint2 c2: CGPoint, t: CGFloat) -> CGFloat {

		let dx = _cubicSlope(t, self.x, c1.x, c2.x, to.x)
		let dy = _cubicSlope(t, self.y, c1.y, c2.y, to.y)

		return atan2(dx, dy)
	}

}


// MARK: - Extension Helpers

private typealias CGPathApplierClosure = @convention(block) (CGPathElement) -> Void

extension CGPath {

	fileprivate func apply(closure: @escaping CGPathApplierClosure) {
		self.apply(info: unsafeBitCast(closure, to: UnsafeMutableRawPointer.self)) { (info, element) in
			let block = unsafeBitCast(info, to: CGPathApplierClosure.self)
			block(element.pointee)
		}
	}

}


extension CGAffineTransform {

	/// Whether or not this transform solely consists of a translation.
	/// Note that the value of this property is `false`, when the receiver is `.identity`.
	fileprivate var isTranslationOnly: Bool {

		if [a, b, c, d].contains(where: { $0 != 0 }) {
			return false
		}

		return tx != 0 || ty != 0
	}

}

extension CGPathElement {

	fileprivate var mx_points: [CGPoint] {
		return Array(UnsafeBufferPointer(start: points, count: type.numberOfPoints))
	}

}

extension CGPathElementType {

	fileprivate var numberOfPoints: Int {
		switch self {
		case .moveToPoint, .addLineToPoint: return 1
		case .addQuadCurveToPoint: return 2
		case .addCurveToPoint: return 3
		case .closeSubpath: return 0
		}
	}

	fileprivate func calculateLength(from: CGPoint,
									 to: CGPoint,
									 controlPoints: [CGPoint]) -> CGFloat {
		switch self {
		case .moveToPoint:
			return 0
		case .addLineToPoint, .closeSubpath:
			return (to - from).norm
		case .addQuadCurveToPoint:
			return from.quadCurveLength(to: to, controlPoint: controlPoints[0])
		case .addCurveToPoint:
			return from.cubicCurveLength(to: to, controlPoint1: controlPoints[0], controlPoint2: controlPoints[1])
		}
	}
}



// MARK: - Method Helpers

private func _quadBezier(_ t: CGFloat, _ start: CGFloat, _ c1: CGFloat, _ end: CGFloat) -> CGFloat {

	let _t = 1 - t
	let _t² = _t * _t
	let t² = t * t

	return  _t² * start + 2 * _t * t * c1 + t² * end
}

private func _quadSlope(_ t: CGFloat, _ start: CGFloat, _ c1: CGFloat, _ end: CGFloat) -> CGFloat {

	let _t = 1 - t

	return  2 * _t * (c1 - start) + 2 * t * (end - c1)
}

private func _cubicBezier(_ t: CGFloat, _ start: CGFloat, _ c1: CGFloat, _ c2: CGFloat, _ end: CGFloat) -> CGFloat {

	let _t = 1 - t
	let _t² = _t * _t
	let _t³ = _t * _t * _t
	let t² = t * t
	let t³ = t * t * t

	return  _t³ * start + 3.0 * _t² * t * c1 + 3.0 * _t * t² * c2 + t³ * end
}

private func _cubicSlope(_ t: CGFloat, _ start: CGFloat, _ c1: CGFloat, _ c2: CGFloat, _ end: CGFloat) -> CGFloat {

	let _t = 1 - t
	let _t² = _t * _t
	let t² = t * t

	return  3 * _t² * (c1 - start) + 6 * _t * t * (c2 - c1) + 3 * t² * (end - c2)
}
