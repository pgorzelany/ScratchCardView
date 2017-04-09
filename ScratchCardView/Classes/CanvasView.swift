//
//  CanvasView.swift
//  Pods
//
//  Created by Piotr Gorzelany on 09/04/2017.
//
//

import UIKit

class CanvasView: UIView {
    
    // MARK: Properties
    
    @IBInspectable var lineWidht: CGFloat = 1
    @IBInspectable var strokeColor = UIColor.black
    
    fileprivate var paths: [CGMutablePath] = []
    fileprivate var currentPath: CGMutablePath?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }
    
    init(strokePaths paths: [CGMutablePath]) {
        self.init()
        
        self.paths = paths
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        for path in self.paths + [self.currentPath].flatMap({$0}) {
            context?.addPath(path)
            context?.setLineWidth(lineWidht)
            context?.strokePath()
        }
    }
    
    // MARK: Actions
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        switch recognizer.state {
        case .began:
            self.beginPath(at: location)
        case .changed:
            self.addLine(to: location)
        default:
            self.closePath()
        }
    }
    
    // MARK: Public methods
    
    func beginPath(at point: CGPoint) {
        self.currentPath = CGMutablePath()
        self.currentPath?.move(to: point)
    }
    
    func addLine(to point: CGPoint) {
        self.currentPath?.addLine(to: point)
        self.setNeedsDisplay()
    }
    
    func closePath() {
        if let currentPath = self.currentPath {
            self.paths.append(currentPath)
        }
        self.currentPath = nil
        self.setNeedsDisplay()
    }
    
    func clear() {
        self.paths = []
        self.setNeedsDisplay()
    }
    
    // MARK: Private Methods
    
    fileprivate func configureView() {
        self.addGestureRecognizers()
    }
    
    fileprivate func addGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
    }
}

