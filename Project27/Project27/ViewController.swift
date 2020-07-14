//
//  ViewController.swift
//  Project27
//
//  Created by Daniel Gx on 01/07/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    var currentDrawType = 0
    
    // MARK: - Actions
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0: drawRectangle()
        case 1: drawCircle()
        case 2: drawCheckerboard()
        case 3: drawRotatedSquares()
        case 4: drawLines()
        case 5: drawImagesAndText()
        case 6: drawEmoji()
        case 7: drawTwin()
        default: break
        }
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }
    
    // MARK: - Methods
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image(actions: { (ctx) in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        })
        
        imageView.image = img
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image(actions: { (ctx) in
            let circle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: circle)
            ctx.cgContext.drawPath(using: .fillStroke)
        })
        
        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let img = renderer.image { (ctx) in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawImagesAndText() {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]

            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attributes)

            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }

        imageView.image = img
    }

    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            let emoji = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.rotate(by: .pi * 2)
            ctx.cgContext.setFillColor(UIColor.blue.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            let memoji = UIImage(named: "emoji")
            memoji?.draw(in: emoji)
        }
        
        imageView.image = img
    }
    
    func drawTwin() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            let cx = ctx.cgContext
            cx.setStrokeColor(UIColor.black.cgColor)
            cx.setLineWidth(1)
            
            // T
            cx.move(to: CGPoint(x: 35, y: 40))
            cx.addLine(to: CGPoint(x: 106, y: 40))
            cx.move(to: CGPoint(x: 70, y: 40))
            cx.addLine(to: CGPoint(x: 70, y: 158))
            
            // W
            cx.move(to: CGPoint(x: 121, y: 40))
            cx.addLine(to: CGPoint(x: 146, y: 158))
            cx.move(to: CGPoint(x: 146, y: 158))
            cx.addLine(to: CGPoint(x: 174, y: 40))
            cx.move(to: CGPoint(x: 174, y: 40))
            cx.addLine(to: CGPoint(x: 199, y: 158))
            cx.move(to: CGPoint(x: 199, y: 158))
            cx.addLine(to: CGPoint(x: 227, y: 40))
            
            // I
            cx.move(to: CGPoint(x: 251, y: 40))
            cx.addLine(to: CGPoint(x: 251, y: 158))
            
            // N
            cx.move(to: CGPoint(x: 286, y: 40))
            cx.addLine(to: CGPoint(x: 286, y: 158))
            cx.move(to: CGPoint(x: 286, y: 40))
            cx.addLine(to: CGPoint(x: 347, y: 158))
            cx.move(to: CGPoint(x: 347, y: 40))
            cx.addLine(to: CGPoint(x: 347, y: 158))
            
            cx.drawPath(using: .fillStroke)

        }

        imageView.image = img
    }
    
    deinit {
        debugPrint("Project was finish")
    }
    
}

