//
//  OProgressView.swift
//  OProgressView
//
//  Created by Edward Paulosky on 2/2/17.
//  Copyright © 2017 epau. All rights reserved.
//

import CoreGraphics
import UIKit


/**
 You use the OProgressView class to show an ellipse to depict the progress of a task over time.

 The OProgressView class provides properties for managing the style of the progress ellipse and for getting and setting values that are pinned to the progress of a task.

 For a progress bar use an instance of the [UIProgressView](https://developer.apple.com/reference/uikit/uiprogressview) class.

 For an indeterminate progress indicator—or, informally, a “spinner”—use an instance of the [UIActivityIndicatorView](https://developer.apple.com/reference/uikit/uiactivityindicatorview) class.
 */
@IBDesignable open class OProgressView: UIView {

  // MARK: - Properties

  /// The current progress shown by the receiver.
  open private(set) var progress: Float = 0.0 { // 0.0 .. 1.0, default is 0.0. values outside are pinned.
    didSet {
      if progress < 0 {
        progress = 0
      } else if progress > 1 {
        progress = 1
      }
      setNeedsDisplay()
    }
  }

  private var destinationProgress: Float = 0.0 {
    didSet {
      if progress < 0 {
        progress = 0
      } else if progress > 1 {
        progress = 1
      }
    }
  }

  /// The progress object to use for updating the progress view.
  open var observedProgress: Progress? {
    didSet {
      if let oldProgress = oldValue,
        oldProgress != observedProgress
      {
        unobserveProgress(progress: oldProgress)
      }

      if let progress = observedProgress {
        observeProgress(progress: progress)
      }
    }
  }

  /// The width of the track around the circle.
  @IBInspectable open var trackWidth: CGFloat = 10 {
    didSet {
      setNeedsDisplay()
    }
  }

  /// The color shown for the portion of the progress bar that is not filled.
  @IBInspectable open var trackTintColor: UIColor? {
    didSet {
      setNeedsDisplay()
    }
  }

  /// An image to use for the portion of the track that is not filled.
  @IBInspectable open var trackImage: UIImage? {
    didSet {
      setNeedsDisplay()
    }
  }

  /// The color shown for the portion of the progress bar that is filled.
  @IBInspectable open var progressTintColor: UIColor? {
    didSet {
      setNeedsDisplay()
    }
  }

  /// An image to use for the portion of the progress bar that is filled.
  @IBInspectable open var progressImage: UIImage? {
    didSet {
      setNeedsDisplay()
    }
  }

  /// The label to display the current progress as a percentage.
  @IBInspectable open lazy var progressLabel: UILabel = {
    let label = UILabel(frame: self.bounds)
    label.textAlignment = .center
    label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    return label
  }()

  /// The color shown in the inside of the circle.
  @IBInspectable open var centerBackgroundColor: UIColor? {
    didSet {
      setNeedsDisplay()
    }
  }

  private lazy var displayLink: CADisplayLink = {
    let displayLink = CADisplayLink(target: self, selector: #selector(displayLinkDidUpdate))
    displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    displayLink.isPaused = true
    return displayLink
  }()

  private lazy var numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    return formatter
  }()

  // MARK: Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    backgroundColor = UIColor.clear
    trackTintColor = UIColor.lightGray
    trackWidth = bounds.width * 0.10
    addSubview(progressLabel)
  }

  deinit {
    guard let progress = self.observedProgress else {
      return
    }

    unobserveProgress(progress: progress)
  }

  // MARK: Drawing

  override open func draw(_ rect: CGRect) {

    // Draw Track
    var adjustedRect = rect
    adjustedRect.origin = CGPoint(x: rect.minX + (trackWidth / 2), y: rect.minY + (trackWidth / 2))
    adjustedRect.size = CGSize(width: rect.width - trackWidth, height: rect.height - trackWidth)

    let circlePath = UIBezierPath(ovalIn: adjustedRect)
    circlePath.lineWidth = trackWidth

    if let trackImage = trackImage {
      UIColor(patternImage: trackImage).setStroke()
    } else {
      trackTintColor?.setStroke()
    }

    circlePath.stroke()


    // Draw Progress
    let progressPath = UIBezierPath(ovalSegmentInRect: adjustedRect, percentage: CGFloat(progress))
    progressPath.lineWidth = trackWidth

    if let progressImage = progressImage {
      UIColor(patternImage: progressImage).setStroke()
    } else {
      if let progressTintColor = progressTintColor {
        progressTintColor.setStroke()
      } else {
        tintColor.setStroke()
      }
    }

    progressPath.stroke()


    // Mask Label
    var centerRect = adjustedRect
    centerRect.origin = CGPoint(x: adjustedRect.minX + (trackWidth / 2) , y: adjustedRect.minY + (trackWidth / 2))
    centerRect.size = CGSize(width: adjustedRect.width - trackWidth, height: adjustedRect.height - trackWidth)

    let centerPath = UIBezierPath(ovalIn: centerRect)

    let layer = CAShapeLayer()
    layer.path = centerPath.cgPath
    progressLabel.layer.mask = layer
    progressLabel.text = numberFormatter.string(for: progress)


    // Draw Center Color
    if let centerBackgroundColor = centerBackgroundColor {
      centerBackgroundColor.setFill()
      centerPath.fill()
    }
  }

  // MARK: Set Progress

  /// Adjusts the current progress shown by the receiver, optionally animating the change.
  open func setProgress(_ progress: Float, animated: Bool) {
    if animated {
      destinationProgress = progress
      displayLink.isPaused = false
    } else {
      self.progress = progress
    }
  }

  // MARK: Display Link

  /// Updates the progress as the display refreshes.
  open func displayLinkDidUpdate() {
    if destinationProgress > progress {
      progress += Float(displayLink.duration)
    } else {
      displayLink.isPaused = true
    }
  }

  // MARK: Observing Progress

  open func observeProgress(progress: Progress) {
    progress.addObserver(self, forKeyPath: #keyPath(Progress.fractionCompleted), options: [.new], context: nil)
  }

  open func unobserveProgress(progress: Progress) {
    progress.removeObserver(self, forKeyPath: #keyPath(Progress.fractionCompleted))
  }

  override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == #keyPath(Progress.fractionCompleted),
      let newProgress = object as? Progress,
      newProgress == observedProgress
    {
      setProgress(Float(newProgress.fractionCompleted), animated: true)
    } else {
      super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
  }
}

