//
//  AboutViewController.swift
//  yinkinChat
//
//  Created by ying kit ng on 4/12/21.
//  Copyright © 2021 ying kit ng. All rights reserved.
//

import UIKit
import AVFoundation

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
extension CGSize {
    init(_ width:CGFloat, _ height:CGFloat) {
        self.init(width:width, height:height)
    }
}
extension CGPoint {
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
}
extension CGVector {
    init (_ dx:CGFloat, _ dy:CGFloat) {
        self.init(dx:dx, dy:dy)
    }
}
extension CGRect {
    var center : CGPoint {
        return CGPoint(self.midX, self.midY)
    }
}


class AboutViewController: UIViewController {
    var player : AVAudioPlayer!
    let  v1 = UIView(frame: CGRect(x: 100, y: 111, width: 132, height: 194))
    @IBOutlet weak var v: UIView!
    @IBAction func doButton(_ sender: Any) {
        
        let anim = UIViewPropertyAnimator(duration: 4, curve: .linear) {
            self.animate()
        }
        anim.startAnimation()
        delay(2) {
            anim.pauseAnimation()
            anim.isReversed = true
            anim.startAnimation()
            // interesting; it reverses the flip but not the contents change
            // on the whole, not likely to be a useful technique?
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        
        let lab = UILabel()
        lab.text = "Hello world"
        lab.textColor = .white
        lab.sizeToFit()
        lab.center = self.view.bounds.center
        self.view.addSubview(lab)
        
        
        // demonstrate use of an asset catalog for miscellaneous resource
        // also demonstrate asset catalog "namespace"
//        let theme = NSDataAsset(name: "./Supporting Files/music/theme")!
//        self.player = try! AVAudioPlayer(data: theme.data)
//        self.player.play()
        
        
        let myAdder = IntAdder([1,2,3,4]) // initializer call
        let intAndErr = myAdder[10] // subscript call
        print(intAndErr) // use nested type
        let result = myAdder.sum() // method call
        print(result)
        myAdder.array = [2,4,6,8] // property access
        let result2 = myAdder.sum() // method call
        print(result2)
        
        
        let s = echo("hi", times:3)
        print(s)
        do {
            let s = "hello"
            let s2 = s.replacingOccurrences(of: "ell", with:"ipp")
            // s2 is now "hippo"
            print(s2)
        }
        
        sayStrings("Manny", "Moe", "Jack", times:1)
        
        // draw some layer
        
        let lay4 = CALayer()
        let im = UIImage(named: "adminImage")!
        lay4.frame = CGRect(origin: CGPoint(0,0), size: im.size)
        lay4.contentsScale = UIScreen.main.scale
        lay4.bounds = lay4.bounds.insetBy(dx: -20, dy: -20)
        lay4.zPosition = 10
        lay4.opacity = 0.2
        lay4.shadowOffset = CGSize(1, 1)
        lay4.contents = im.cgImage
        self.view.layer.addSublayer(lay4)
        delay(2) {
            lay4.transform = CATransform3DMakeRotation(.pi, 0, 1, 0)
            lay4.zPosition = 10
            lay4.setValue(Float.pi/2, forKey: "transform.rotation.x")
            //lay4.bounds = CGRect(0,0,40,40)
            //lay4.setValue(Float.pi/2, forKey: "scale.x")
            //lay4.transform = CATransform3DScale(CATransform3D(), 0.9 , 0.9, 0.9)
            //lay4.frame = CGRect(origin: CGPoint(0,0), size: CGSize.init(50, 50))
        }
        
        let empty = UIGraphicsImageRenderer(size: im.size).image {_ in}
        let arr = [im, empty , im, empty , im]
        let iv = UIImageView(image: im)
        iv.frame.origin = CGPoint(100, 100)
        iv.animationImages = arr
        iv.animationDuration = 2
        iv.animationRepeatCount = 1
        iv.startAnimating()
    }
    

    //animation and transition
    func animate() {
        let opts : UIView.AnimationOptions = .transitionFlipFromLeft
        UIView.transition(with:self.v, duration: 0.8, options: opts,
            animations: {
                //self.v.image = UIImage(named:"Smiley")
            })
        
        // ======
        
//        do { // looks a little more compelling if we do a curl up transition
//            let opts : UIView.AnimationOptions = .transitionCurlUp
//            self.v.reverse.toggle()
//            UIView.transition(with:self.v, duration: 1, options: opts,
//                              animations: {
//                                self.v.setNeedsDisplay()
//            })
//        }
        
        // ======
                
//        let opts2 : UIView.AnimationOptions = [.transitionFlipFromLeft, .allowAnimatedContent]
//        UIView.transition(with:self.v, duration: 1, options: opts2,
//            animations: {
//                var f = self.v.frame
//                f.size.width = self.v.frame.width
//                f.origin.x = 0
//                self.v.frame = f
//            })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



// Class exmaple
class IntAdder {
    var array : [Int] // property
    init(_ array : [Int]) { // initializer
        self.array = array
    }
    func sum() -> Int { // method
        return self.array.reduce(0,+)
    }
    enum MyError { // nested type
        case outOfBounds
    }
    subscript(ix:Int) -> (Int?, MyError?) { // subscript
        if self.array.indices.contains(ix) {
            return (self.array[ix], nil)
        }
        return (nil, .outOfBounds)
    }
}
