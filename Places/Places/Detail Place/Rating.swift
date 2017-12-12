//
//  Rating.swift
//  Places
//
//  Created by adminaccount on 11/27/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class Rating: UIView {

    
    var rating: Double = 0.0
    
    var starPoints = [CGPoint] ()
    var filledHalf = [CGPoint] ()
    var emptyHalf = [CGPoint] ()
    
    var starSize: CGFloat = 0
    
    var leadingPoint: CGPoint = CGPoint()
    var tralingPoint: CGPoint = CGPoint()
    var ratingRule: CGFloat = 0
    
    var firstColor: CGColor = UIColor.yellow.cgColor
    var secondColor: CGColor = UIColor.white.cgColor
    
    init (x: Double, y: Double, height: Double, currentRate: Double, mainColor: CGColor = UIColor.yellow.cgColor, backColor: CGColor = UIColor.white.cgColor) {
        let frame = CGRect(x: x, y: y, width: height * 5, height: height)
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        firstColor = mainColor
        secondColor = backColor
        starSize = CGFloat(height)
        rating = currentRate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.cyan
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.clear(rect)
        var center = CGPoint(x: starSize/2, y: rect.midY)
        let radius = rect.maxY/2
        var split = CGFloat(rating)
        
        for _ in 1...5 {
            setStarPointsArray(centralPoint: center, longBeam: radius, shortBeam: radius/2)
            switch split {
            case 0..<1:
                setFilledHalfArray(split)
                if split < 0.5 {
                    drawStar(context: context, points: starPoints, color: firstColor)
                    drawStar(context: context, points: emptyHalf, color: secondColor)
                }
                else {
                    drawStar(context: context, points: starPoints, color: secondColor)
                    drawStar(context: context, points: filledHalf, color: firstColor)
                }
            case ..<0:
                drawStar(context: context, points: starPoints, color: secondColor)
            case 1... :
                drawStar(context: context, points: starPoints, color: firstColor)
            default:
                break
            }
            center.x += starSize
            split -= 1
        }
    }
    
    func offsetX(coordinate: Double) ->CGFloat {
        return CGFloat( cos(coordinate * Double.pi / 180) )
    }
    
    func offsetY(coordinate: Double) ->CGFloat {
        return CGFloat( sin(coordinate * Double.pi / 180) )
    }
    
    func drawStar(context: CGContext, points: [CGPoint], color: CGColor) {
        context.beginPath()
        context.setFillColor(color)
        context.move(to: points[0])
        for dot in points {
            context.addLine(to: dot)
        }
        context.closePath()
        context.fillPath()
    }
    
    func setFilledHalfArray(_ split: CGFloat) {
        var splitPoint = CGPoint(x: leadingPoint.x + ratingRule * split, y: 0)
        
        filledHalf.append(starPoints[0])
        
        for currentIndex in 1...10 {
            
            if  ( ( starPoints[currentIndex].x >= splitPoint.x) && starPoints[currentIndex - 1].x < splitPoint.x ) ||
                ( starPoints[currentIndex].x < splitPoint.x && ( starPoints[currentIndex - 1].x >= splitPoint.x ) ) {
                
                splitPoint.y = ( ( splitPoint.x - starPoints[currentIndex - 1].x) / (starPoints[currentIndex].x - starPoints[currentIndex - 1].x) ) * (starPoints[currentIndex].y - starPoints[currentIndex - 1].y) + starPoints[currentIndex - 1].y
                
                filledHalf.append(splitPoint)
                
                emptyHalf.append(splitPoint)
            }
            
            if ( starPoints[currentIndex].x < splitPoint.x ) {
                filledHalf.append(starPoints[currentIndex])
            }
            
            if ( starPoints[currentIndex].x > splitPoint.x ) {
                emptyHalf.append(starPoints[currentIndex])
            }
        }
    }
    
    func setStarPointsArray(centralPoint: CGPoint, longBeam: CGFloat, shortBeam: CGFloat) {
        starPoints =
            [CGPoint(x: offsetX(coordinate: -162) * longBeam + centralPoint.x,
                     y: offsetY(coordinate: -162) * longBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: -126) * shortBeam + centralPoint.x,
                     y: offsetY(coordinate: -126) * shortBeam + centralPoint.y),
             CGPoint(x: centralPoint.x,
                     y: offsetY(coordinate: -90) * longBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: -54) * shortBeam  + centralPoint.x,
                     y: offsetY(coordinate: -54) * shortBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: -18) * longBeam  + centralPoint.x,
                     y: offsetY(coordinate: -18) * longBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: 18) * shortBeam  + centralPoint.x,
                     y: offsetY(coordinate: 18) * shortBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: 54) * longBeam  + centralPoint.x,
                     y: offsetY(coordinate: 54) * longBeam + centralPoint.y),
             CGPoint(x: centralPoint.x,
                     y: offsetY(coordinate: 90) * shortBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: 126) * longBeam  + centralPoint.x,
                     y: offsetY(coordinate: 126) * longBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: 162) * shortBeam  + centralPoint.x,
                     y: offsetY(coordinate: 162) * shortBeam + centralPoint.y),
             CGPoint(x: offsetX(coordinate: -162) * longBeam + centralPoint.x,
                     y: offsetY(coordinate: -162) * longBeam + centralPoint.y)]
        
        leadingPoint = starPoints[0]
        tralingPoint = starPoints[4]
        ratingRule = tralingPoint.x - leadingPoint.x
    }
}
