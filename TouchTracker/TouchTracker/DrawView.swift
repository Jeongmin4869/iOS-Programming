import UIKit

class DrawView: UIView{
    
    //var currentLine: Line?
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    var selectedLineIndex: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTapRecognizer.numberOfTapsRequired = 1
        singleTapRecognizer.delaysTouchesBegan = true
        //doubleTapRecognizer을 실패할 경우 singleTapRecognizer가 수행된다.
        singleTapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(singleTapRecognizer)
        
    }
    
    @objc func doubleTap(gestureRecognizer: UITapGestureRecognizer){
        print(#function)
        currentLines.removeAll()
        finishedLines.removeAll()
        setNeedsDisplay()
    }
    
    @objc func singleTap(gestureRecognizer: UITapGestureRecognizer){
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = IndexOfLineAtPoint(point: point)
        setNeedsDisplay() // draw를 호출
    }
    
    func IndexOfLineAtPoint(point: CGPoint) -> Int?{
        for(index, line) in finishedLines.enumerated(){
            let begin = line.begin
            let end = line.end
            for t: CGFloat in stride(from: 0.0, to: 1.0, by: 0.05){
                let x = begin.x + (end.x - begin.x) * t
                let y = begin.y + (end.y - begin.y) * t
                if hypot(x - point.x, y - point.y) < 20.0 {
                    return index
                }
            }
        }
        return nil
    }
    
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
        
        if let index = selectedLineIndex{
            UIColor.blue.setStroke()
            let selectedLine = finishedLines[index]
            strokeLine(line: selectedLine)
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
