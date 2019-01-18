//
//  DisplayLink.swift
//  Pixel-iOS
//
//  Created by José Donor on 06/12/2018.
//


/// Wraps a CADisplayLink allowing to simply update display on every frame
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

	/// Initialize DisplayLink
	///
	/// - Parameters:
	///   - lifespan: Duration of DisplayLink before it ends
	///   - fps: Frames per second rate
	///   - update: Update callback with parameters : timestamp, isCompleted & isCanceled
	public init(lifespan: Double? = nil,
				fps: Int? = nil,
				update: @escaping (_ timestamp: Double, _ isCompleted: Bool, _ isCanceled: Bool) -> Void) {

		self.lifespan = lifespan
		self.update = update

		super.init()

        set(fps: fps)
		displayLink!.add(to: .current, forMode: RunLoop.Mode.common)

	}

    private func set(fps fps_target: Int?) {

        guard
			let fps_target = fps_target,
			fps_target != 0
			else { return }

        let fps_max: Int

        if #available(iOS 10.0, *) { fps_max = displayLink!.preferredFramesPerSecond }
        else { fps_max = 60 }

        var i = 2
        while fps_target <= fps_max / i { i += 1 }
        i -= 1

		let fps = fps_max / i

        if #available(iOS 10.0, *) { displayLink!.preferredFramesPerSecond = fps }
        else { displayLink!.frameInterval = i }

    }

	deinit {
		stop(isCanceled: true)
	}



	// MARK: - Stop

	/// Stops CADisplayLink
	public func stop(isCanceled: Bool) {

        if let timestamp = displayLink?.timestamp {
            update?(timestamp - start, !isCanceled, isCanceled)
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

		if isCompleted { stop(isCanceled: false) }
		else { update?(timestamp, false, false) }

	}

}
