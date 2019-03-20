//
//  Gradient+CG.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


extension Gradient {

	/// Draws Gradient on a CGContext
	public func draw(in bounds: CGRect,
					 context: CGContext) {

			switch self {

			case let .linear(colors, start, end, isRelative):

				Gradient.drawLinearGradient(colors: colors,
											start: start,
											end: end,
											isRelative: isRelative,
											bounds: bounds,
											context: context)

			case let .radial(colors, startCenter, endCenter, startRadius, endRadius, isRelative):

				Gradient.drawRadialGradient(colors: colors,
											startCenter: startCenter,
											endCenter: endCenter,
											startRadius: startRadius,
											endRadius: endRadius,
											isRelative: isRelative,
											bounds: bounds,
											context: context)

			case let .conical(colors, center, startRadius, endRadius, isRelative, startAngle, endAngle):

				Gradient.drawConicalGradient(colors: colors,
											 center: center,
											 startRadius: startRadius,
											 endRadius: endRadius,
											 isRelative: isRelative,
											 startAngle: startAngle,
											 endAngle: endAngle,
											 bounds: bounds,
											 context: context)

			}


	}


	// MARK: - Helpers

	private static func drawLinearGradient(colors: Colors,
										   start: CGPoint,
										   end: CGPoint,
										   isRelative: Bool,
										   bounds: CGRect,
										   context: CGContext) {

		var start = start
		var end = end

		if isRelative {

			start.x *= bounds.width
			start.y *= bounds.height

			end.x *= bounds.width
			end.y *= bounds.height

		}

		context.drawLinearGradient(colors.cgGradient,
								   start: start,
								   end: end,
								   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])

	}

	private static func drawRadialGradient(colors: Colors,
										   startCenter: CGPoint,
										   endCenter: CGPoint,
										   startRadius: CGFloat,
										   endRadius: CGFloat,
										   isRelative: Bool,
										   bounds: CGRect,
										   context: CGContext) {

		var startCenter = startCenter
		var endCenter = endCenter
		var startRadius = startRadius
		var endRadius = endRadius

		if isRelative {

			startCenter.x *= bounds.width
			startCenter.y *= bounds.height

			endCenter.x *= bounds.width
			endCenter.y *= bounds.height

			let length = min(bounds.width, bounds.height)

			startRadius *= length
			endRadius *= length

		}

		context.drawRadialGradient(colors.cgGradient,
								   startCenter: startCenter,
								   startRadius: startRadius,
								   endCenter: endCenter,
								   endRadius: endRadius,
								   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])

	}

	private static func drawConicalGradient(colors: Colors,
											center: CGPoint,
											startRadius: CGFloat,
											endRadius: CGFloat,
											isRelative: Bool,
											startAngle: CGFloat,
											endAngle: CGFloat,
											bounds: CGRect,
											context: CGContext) {

		let kernel = Gradient.kernel(locations: colors.locations.map { CGFloat($0) })


		let scale = UIScreen.main.scale
		let extent = CGRect(origin: .zero,
							size: bounds.size * scale)

		let startAngle = startAngle.truncatingRemainder(dividingBy: 2 * .pi)
			+ (startAngle < 0 ? 2 * .pi : 0)
		let endAngle = endAngle.truncatingRemainder(dividingBy: 2 * .pi)
			+ (endAngle < 0 ? 2 * .pi : 0)

		var center = center
		var startRadius = startRadius
		var endRadius = endRadius

		if isRelative {

			center.x *= extent.width
			center.y *= extent.height

			let length = min(extent.width, extent.height)

			startRadius *= length
			endRadius *= length

		}
		else {
			center.x *= scale
			center.y *= scale
			startRadius *= scale
			endRadius *= scale
		}

		let ciContext = CIContext(options: nil)
		guard let colorKernel = CIColorKernel(source: kernel) else { return }

		var arguments: [Any] = colors.colors
			.sorted(by: { $0.key < $1.key })
			.map { CIColor(color: $0.value) }

		arguments.append(contentsOf: [
			CIVector(cgPoint: center),
			startRadius,
			endRadius,
			startAngle,
			endAngle
		])


		guard let output = colorKernel.apply(extent: extent, arguments: arguments) else { return }

		guard let cgImage = ciContext.createCGImage(output, from: extent) else { return }

		context.draw(cgImage, in: bounds)

	}

	private static func kernel(locations: [CGFloat]) -> String {

		let count = locations.count

		var kernel = "kernel vec4 circularGradientKernel("

		(1...count).forEach {
			kernel.append("__color color_\($0), ")
		}

		kernel.append("""
		vec2 center, float startRadius, float endRadius, float startAngle, float endAngle) {\n
		vec2 point = destCoord() - center;
		float radius = sqrt(point.x * point.x + point.y * point.y);
		float theta = mod(-atan(point.y, point.x), radians(360.0));
		if (radius < startRadius || endRadius < radius || theta < startAngle || endAngle < theta) { return vec4(0.0, 0.0, 0.0, 0.0); }
		float end0 = startAngle;
		""")

		locations
			.enumerated()
			.dropFirst()
			.forEach { index, location in
				kernel.append("""
				float start\(index) = end\(index - 1);
				float end\(index) = startAngle+(endAngle-startAngle)*\(location);
				if (theta == endAngle || theta < end\(index)) {
				return mix(color_\(index), color_\(index + 1), (theta-start\(index))/(end\(index)-start\(index)));
				}
				""")
			}

		kernel.append("}")

		return kernel
	}

}
