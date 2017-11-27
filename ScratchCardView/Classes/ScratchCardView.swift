//
//  ScratchCardView.swift
//  Pods
//
//  Created by Piotr Gorzelany on 08/04/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit

/// The ScratchCardViewDelegate interface
@objc public protocol ScratchCardViewDelegate: class {
    
    /// The top view of the scratch card. Covers the content view.
    ///
    /// - Parameter scratchCardView: the view that asks for the cover view.
    /// - Returns: The method should return a cover view for the scratch card
    func coverView(for scratchCardView: ScratchCardView) -> UIView
    
    /// The content view of the scratch card.
    /// It is initialy covered and is revealed after scratching the view.
    ///
    /// - Parameter scratchCardView: The view that asks for the content view.
    /// - Returns: The method should return a content view for the scratch card
    func contentView(for scratchCardView: ScratchCardView) -> UIView
    
    /// Gets called when scratching starts
    ///
    /// - Parameters:
    ///   - view: The scratch card
    ///   - point: The point at which the scratches started. In the scratch card coordinate system
    @objc optional func scratchCardView(_ view: ScratchCardView, didStartScratchingAt point: CGPoint)
    
    /// Called when scratches are in progress
    ///
    /// - Parameters:
    ///   - view: The scratch card
    ///   - point: The point to which the scratching finger moved. In the scratch card coordinate system
    @objc optional func scratchCardView(_ view: ScratchCardView, didScratchTo point: CGPoint)
    
    /// Called when current scratches stop (user lifts his finger)
    ///
    /// - Parameter view: The scratch card
    @objc optional func scratchCardViewDidEndScratching(_ view: ScratchCardView)
}

/// The ScratchCardView
open class ScratchCardView: UIView {

    // MARK: Properties
    
    /// The width of the scratch. Default is 30.
    @IBInspectable public var scratchWidth: CGFloat = 30 {
        didSet {
            canvasMaskView.lineWidth = scratchWidth
        }
    }
    
    /// The percent of total view area that is revealed by the scratches.
    /// Computing this property requires heavy CPU work,
    /// consider doing it on a backgroung thread if used frequently.
    ///
    /// Returns: a value between 0 and 1
    public var scratchPercent: Double {
        return getScratchPercent()
    }
    
    private var coverViewContainer = UIView()
    private var contentViewContainer = UIView()
    private var canvasMaskView = CanvasView()
    
    // MARK: Delegate
    
    /// The delegate for the ScratchCardView
    ///
    /// The delegate is responsible for providing the content and cover views.
    /// It also gets notified of important events like scratch start or end.
    public weak var delegate: ScratchCardViewDelegate? {
        didSet {
            reloadView()
        }
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        canvasMaskView.frame = contentViewContainer.bounds
    }
    
    // MARK: Configuration
    
    private func configureView() {
        self.addGestureRecognizers()
        configureMaskView()
        contentViewContainer.backgroundColor = UIColor.clear
        coverViewContainer.backgroundColor = UIColor.clear
        addSubviewFullscreen(coverViewContainer)
        addSubviewFullscreen(contentViewContainer)
    }
    
    private func configureMaskView() {
        canvasMaskView.delegate = self
        canvasMaskView.backgroundColor = UIColor.clear
        canvasMaskView.strokeColor = UIColor.black
        canvasMaskView.lineWidth = scratchWidth
        contentViewContainer.mask = canvasMaskView
    }
    
    private func addGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(
            target: canvasMaskView,
            action: #selector(canvasMaskView.panGestureRecognized)
        )
        self.addGestureRecognizer(panRecognizer)
    }
    
    // MARK: Private methods
    
    private func getScratchPercent() -> Double {
        // Since the transparency is inverted, the cover view gets transparent if the mask is not transparent
        // So we need to check how many pixels are NOT transparent in the mask
        return (1.0 - canvasMaskView.getTransparentPixelsPercent())
    }
    
    // MARK: Public Methods
    
    /// Clears the scratches from the current view
    public func clear() {
        canvasMaskView.clear()
    }
    
    /// Clears the scratches and asks the delegate for a new cover and contant views
    public func reloadView() {
        clear()
        (coverViewContainer.subviews + contentViewContainer.subviews).forEach { (subview) in
            subview.removeFromSuperview()
        }
        guard let coverView = delegate?.coverView(for: self),
            let contentView = delegate?.contentView(for: self) else {
            return
        }
        coverViewContainer.addSubviewFullscreen(coverView)
        contentViewContainer.addSubviewFullscreen(contentView)
    }
}

extension ScratchCardView: CanvasViewDelegate, UITableViewDelegate {
    
    func canvasViewDidStartDrawing(_ view: CanvasView, at point: CGPoint) {
        delegate?.scratchCardView?(self, didStartScratchingAt: point)
    }
    
    func canvasViewDidAddLine(_ view: CanvasView, to point: CGPoint) {
        delegate?.scratchCardView?(self, didScratchTo: point)
    }
    
    func canvasViewDidEndDrawing(_ view: CanvasView) {
        delegate?.scratchCardViewDidEndScratching?(self)
    }
}
