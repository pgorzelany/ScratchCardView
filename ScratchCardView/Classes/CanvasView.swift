//
//  CanvasView.swift
//  Pods
//
//  Created by Piotr Gorzelany on 09/04/2017.
//
//

import UIKit

protocol CanvasViewDelegate: class {
    
    func canvasViewDidStartDrawing(_view: CanvasView, at point: CGPoint)
    func canvasViewDidAddLine(_ view: CanvasView, to point: CGPoint)
    func canvasViewDidEndDrawing(_ view: CanvasView)
}

class CanvasView: UIView {
    
    // MARK: Properties
    
    weak var delegate: CanvasViewDelegate?
    
    @IBInspectable var lineWidth: CGFloat = 10
    @IBInspectable var strokeColor = UIColor.black
    
    fileprivate var paths: [CGMutablePath] = []
    fileprivate var currentPath: CGMutablePath?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(strokeColor.cgColor)
        context?.setLineWidth(lineWidth)
        for path in paths + [currentPath].flatMap({$0}) {
            context?.addPath(path)
            context?.strokePath()
        }
    }
    
    // MARK: Actions
    
    @objc func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        switch recognizer.state {
        case .began:
            beginPath(at: location)
            delegate?.canvasViewDidStartDrawing(_view: self, at: location)
        case .changed:
            addLine(to: location)
            delegate?.canvasViewDidAddLine(self, to: location)
        default:
            closePath()
            delegate?.canvasViewDidEndDrawing(self)
        }
    }
    
    // MARK: Public methods
    
    func beginPath(at point: CGPoint) {
        currentPath = CGMutablePath()
        currentPath?.move(to: point)
    }
    
    func addLine(to point: CGPoint) {
        currentPath?.addLine(to: point)
        setNeedsDisplay()
    }
    
    func closePath() {
        if let currentPath = currentPath {
            paths.append(currentPath)
        }
        currentPath = nil
        setNeedsDisplay()
    }
    
    func clear() {
        paths = []
        setNeedsDisplay()
    }
    
    // MARK: Private Methods
    
    fileprivate func configureView() {
        addGestureRecognizers()
    }
    
    fileprivate func addGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        addGestureRecognizer(panRecognizer)
    }
}

