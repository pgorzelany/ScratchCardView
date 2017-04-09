//
//  ScratchCardView.swift
//  Pods
//
//  Created by Piotr Gorzelany on 08/04/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit

public protocol ScratchCardViewDelegate: class {
    
    func coverView(for scratchCardView: ScratchCardView) -> UIView
    func contentView(for scratchCardView: ScratchCardView) -> UIView
}

open class ScratchCardView: UIView {

    // MARK: Properties
    
    @IBInspectable public var scratchWidth: CGFloat = 30
    
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
        canvasMaskView.backgroundColor = UIColor.clear
        canvasMaskView.strokeColor = UIColor.black
        canvasMaskView.lineWidht = scratchWidth
        contentViewContainer.mask = canvasMaskView
    }
    
    private func addGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(
            target: canvasMaskView,
            action: #selector(canvasMaskView.panGestureRecognized)
        )
        self.addGestureRecognizer(panRecognizer)
    }
    
    private func clearView() {
        canvasMaskView.clear()
        (coverViewContainer.subviews + contentViewContainer.subviews).forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
    
    // MARK: Public Methods
    
    public func reloadView() {
        clearView()
        guard let coverView = delegate?.coverView(for: self),
            let contentView = delegate?.contentView(for: self) else {
            return
        }
        coverViewContainer.addSubviewFullscreen(coverView)
        contentViewContainer.addSubviewFullscreen(contentView)
    }
}
