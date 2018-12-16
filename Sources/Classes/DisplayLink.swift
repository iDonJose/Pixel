//
//  DisplayLink.swift
//  Pixel-iOS
//
//  Created by José Donor on 06/12/2018.
//


public final class DisplayLink: NSObject {

	/// Display link
	private lazy var displayLink: CADisplayLink? = CADisplayLink(target: self, selector: #selector(didUpdate(displaylink:)))

	/// Update block
    private var update: ((_ timestamp: Double, _ isCompleted: Bool, _ isCanceled: Bool) -> Void)?

	/// Lifespan
	private let lifespan: Double?
    /// Start timestamp
    private var start: Double!



	// MARK: - Initialize

	public init(lifespan: Double? = nil,
				fps: Int = 0,
				update: @escaping (_ timestamp: Double, _ isCompleted: Bool, _ isCanceled: Bool) -> Void) {

		self.lifespan = lifespan
		self.update = update

		super.init()

		if #available(iOS 10.0, *) {
			displayLink!.preferredFramesPerSecond = fps
		}

		displayLink!.add(to: .current, forMode: RunLoop.Mode.common)

	}

	deinit {
		invalidate()
	}



	// MARK: - Clean up

	public func invalidate() {

        if let timestamp = displayLink?.timestamp {
            update?(timestamp, false, true)
        }

        update = nil
		displayLink?.invalidate()
		displayLink = nil
	}



	// MARK: - Call back

	@objc
	func didUpdate(displaylink: CADisplayLink) {

        if start == nil { start = displaylink.timestamp }


        let timestamp = displaylink.timestamp - start

        var isCompleted = false

        if let lifespan = self.lifespan {
            if #available(iOS 10.0, *) {
                if displaylink.targetTimestamp - start > lifespan { isCompleted = true }
            }
            else {
                if timestamp >= lifespan { isCompleted = true }
            }
        }


		update?(timestamp, isCompleted, false)

        if isCompleted { invalidate() }

	}

}
