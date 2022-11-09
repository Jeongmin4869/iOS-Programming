import UIKit

class DrawView: UIView{
    
    //var currentLine: Line?
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    func strokeLine(line: Line){
        let path = UIBezierPath()
        path.lineWidth = lineThickness;
        path.lineCapStyle = CGLineCap.round
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        //UIColor.black.setStroke()
        finishedLineColor.setStroke();
        for line in finishedLines{
            strokeLine(line: line)
        }
        //if let line = currentLine{
        //    UIColor.red.setStroke()
        //    strokeLine(line: line)
        //}
        currentLineColor.setStroke()
        //UIColor.red.setStroke()
        for (_,line) in currentLines{
            strokeLine(line: line)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        
        //let touch = touches.first!
        //let location = touch.location(in: self)
        //currentLine = Line(begin: location, end: location)
    
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        //let touch = touches.first!
        //let location = touch.location(in: self)
        //currentLine?.end = location
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key]{
                line.end = touch.location(in: self)
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        
        //if var line = currentLine{
        //    let touch = touches.first!
        //    let location = touch.location(in: self)
        //    line.end = location
        //    finishedLines.append(line)
        //}
        //currentLine = nil
        setNeedsDisplay()
    }
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10{
        didSet{
            setNeedsDisplay()
        }
    }
}
