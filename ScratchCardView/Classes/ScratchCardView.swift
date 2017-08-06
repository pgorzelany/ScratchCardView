//
//  ScratchCardView.swift
//  Pods
//
//  Created by Piotr Gorzelany on 08/04/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit

public protocol ScratchCardViewDelegate: class {
    
    /** The top view of the scratch card. Covers the content view. */
    func coverView(for scratchCardView: ScratchCardView) -> UIView
    
    /** The content view of the scratch card. 
     It is initialy covered and is revealed after scratching the view. 
     */
    func contentView(for scratchCardView: ScratchCardView) -> UIView
    
    func scratchCardView(_ view: ScratchCardView, didStartScratchingAt point: CGPoint)
    func scratchCardView(_ view: ScratchCardView, didScratchTo point: CGPoint)
    func scratchCardViewDidEndScratching(_ view: ScratchCardView)
}

open class ScratchCardView: UIView {

    // MARK: Properties
    
    @IBInspectable public var scratchWidth: CGFloat = 30 {
        didSet {
            canvasMaskView.lineWidth = scratchWidth
        }
    }
    
    private var coverViewContainer = UIView()
    private var contentViewContainer = UIView()
    private var canvasMaskView = CanvasView()
    
    // MARK: Delegate
    
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
    
    // MARK: Public Methods
    
    /**
     Clears the scratches
     */
    public func clear() {
        canvasMaskView.clear()
    }
    
    /**
     Asks the delegate for a new cover and contant views
     */
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
    
    func canvasViewDidStartDrawing(_view: CanvasView, at point: CGPoint) {
        delegate?.scratchCardView(self, didStartScratchingAt: point)
    }
    
    func canvasViewDidAddLine(_ view: CanvasView, to point: CGPoint) {
        delegate?.scratchCardView(self, didScratchTo: point)
    }
    
    func canvasViewDidEndDrawing(_ view: CanvasView) {
        delegate?.scratchCardViewDidEndScratching(self)
    }
}
