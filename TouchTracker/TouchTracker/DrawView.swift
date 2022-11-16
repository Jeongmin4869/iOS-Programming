import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate{
    
    var moveRecognizer: UIPanGestureRecognizer!
    
    //var currentLine: Line?
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    var selectedLineIndex: Int?{
        didSet{
            if selectedLineIndex == nil {
                let menuController = UIMenuController.shared
                menuController.setMenuVisible(false, animated: true)
            }
        }
    }
    
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
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPress))
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveLine))
        moveRecognizer.cancelsTouchesInView = false // touch와 pan 모두 인식
        moveRecognizer.delegate = self // 이 인신기만 다른 제스처인식기와 동시에 발생하도록 한다.
        addGestureRecognizer(moveRecognizer)
        
    }
    
    @objc func doubleTap(gestureRecognizer: UITapGestureRecognizer){
        print(#function)
        currentLines.removeAll()
        finishedLines.removeAll()
        selectedLineIndex = nil
        setNeedsDisplay()
    }
    
    @objc func singleTap(gestureRecognizer: UITapGestureRecognizer){
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = IndexOfLineAtPoint(point: point)
        
        let menuController = UIMenuController.shared
        if selectedLineIndex != nil {
            becomeFirstResponder()
            let deleteItem = UIMenuItem(title: "Delete", action: #selector(deleteLine))
            menuController.menuItems = [deleteItem]
            menuController.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), in: self)
            menuController.setMenuVisible(true, animated: true)
        }
        else {
            menuController.setMenuVisible(false, animated: true)
        }
        setNeedsDisplay() // draw를 호출
    }
    
    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let point = gestureRecognizer.location(in: self)
            selectedLineIndex = IndexOfLineAtPoint(point: point)
            
            if selectedLineIndex != nil {
                currentLines.removeAll(keepingCapacity: false)
            }
        }
        else if gestureRecognizer.state == .ended {
            selectedLineIndex = nil
        }
        setNeedsDisplay()
    }
    
    @objc func moveLine(gestureRecognizer: UIPanGestureRecognizer){
        if let index = selectedLineIndex {
            if gestureRecognizer.state == .changed {
                let translation = gestureRecognizer.translation(in: self)
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                
                setNeedsDisplay()
            }
        }
    }
    
    //moveRecognizer에 대해서는 true를 return, 다른 제스처는 delegate가 없어 false를 return
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true //long과 pan이 동시에 발생할 경우 pan만 인식됨
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
        finishedLineColor.setStroke()
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
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    @objc func deleteLine(sender: AnyObject){
        if let index = selectedLineIndex{
            finishedLines.remove(at: index)
            selectedLineIndex = nil
            setNeedsDisplay()
        }
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
