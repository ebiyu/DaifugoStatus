//
//  ViewController.swift
//  Daifugo Status
//
//  Created by 海老原祐輔 on 2017/06/24.
//  Copyright © 2017年 海老原祐輔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isRevolution = false;
    
    
    var RotationAngle = 0;
    enum direction {
        case cw
        case ccw
    }
    var RotatingDirection:direction = .cw;
    
    var timer: Timer!
    
    @IBOutlet weak var RotationgArrow: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ジェスチャーの生成
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.Tap))
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.LongPress))
        
        // ジェスチャーの追加
        self.view.addGestureRecognizer(tapGestureRecognizer)
        self.view.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    //画面が表示される前にタイマーを開始
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.rotateWithTimer), userInfo: nil, repeats: true);
        timer.fire();
    }
    
    //画面が表示されなくなったらタイマーを終了
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true);
        timer.invalidate();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //タップ時の処理
    //回転方向を切り替える
    func Tap(gestureRecognizer: UITapGestureRecognizer) {
        if RotatingDirection == .cw {
            RotatingDirection = .ccw;
        }else{
            RotatingDirection = .cw;
        }
    }
    
    //長押し時の処理
    //背景色を切り替える
    func LongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began{
            isRevolution = !isRevolution
        }
    }
    
    //0.1秒ごとに実行
    //マークの回転処理
    func rotateWithTimer(){
        RotationAngle += 5;
        if RotationAngle==360 {
            RotationAngle=0;
        }
        
        if RotatingDirection == .cw {
            let angle = (Double)(RotationAngle) * 3.14 / 180;
            let RotateAffine = CGAffineTransform(rotationAngle: CGFloat(angle));
            RotationgArrow.transform = RotateAffine;
        }else{
            let angle = (Double)(RotationAngle) * 3.14 / 180;
            let RotateAffine = CGAffineTransform(rotationAngle: CGFloat(angle));
            let TurnOverAffine = CGAffineTransform(scaleX: -1 , y:1);
            RotationgArrow.transform = RotateAffine.concatenating(TurnOverAffine);
        }
        if isRevolution{
            self.view.backgroundColor = UIColor.red;
        }else{
            self.view.backgroundColor = UIColor.green;
        }
    }
    
    
    
}

