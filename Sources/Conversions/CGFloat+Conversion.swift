//
//  CGFloat+Conversion.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//

#if USE_TEXTURE
import AsyncDisplayKit
#endif



extension CGFloat {

	public var to: Converter {
		return Converter(self)
	}


	public struct Converter {

		private let value: CGFloat

		fileprivate init (_ value: CGFloat) {
			self.value = value
		}


		public var bool: Bool {
			return Bool(value != 0)
		}

		public var uint: UInt {
			return UInt(value)
		}

		public var int: Int {
			return Int(value)
		}

		public var float: Float {
			return Float(value)
		}

		public var double: Double {
			return Double(value)
		}

		public var decimal: Decimal {
			return Decimal(double)
		}

		public var string: String {
			return value.description
		}


		#if USE_TEXTURE
		public var points: ASDimension {
			return ASDimension(unit: .points, value: value)
		}

		public var fraction: ASDimension {
			return ASDimension(unit: .fraction, value: value)
		}
		#endif

	}

}
