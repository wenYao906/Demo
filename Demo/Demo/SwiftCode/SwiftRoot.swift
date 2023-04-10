//
//  SwiftRoot.swift
//  Demo
//
//  Created by study on 2023/1/12.
//

import UIKit

class SwiftRoot: UIViewController {
    
    /// 1.1.4 创建卡片记录的Label
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardsBtn: [UIButton]!
    
    var emojiChoices = ["🎃","😈","🎃","😈"]
    
    
    /// 1.1.5 创建一个变量，用来记录卡片的点击次数
    var flipCount = 0 {
        didSet {
            // 1.1.7 给记录卡片的Label 添加数据
            flipCountLabel.text = "Flips:\(flipCount)"
        }
    }
    
    /// 1.1.6 创建一个变量，用来保存所有的卡片
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /// 1.1.1 在SB中创建一个UIButton，连线到 ViewController 类中
    /// - Parameter sender: 点击的卡片
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        // 获取点击按钮的索引
        if let cardNumber = cardsBtn.firstIndex(of: sender) {
            // 1.1.3 调用卡片翻转方法
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }else{
            print("没有获取到点击按钮的索引")
        }
    }
    
    
    /// 1.1.2 点击卡片的时候，卡片有一个翻转的效果
    /// - Parameters:
    ///   - emoji: emoji 图片
    ///   - button: 按钮
    func flipCard(withEmoji emoji: String, on button: UIButton){
        // 1.1.2.1 让卡片翻转
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.orange
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
        }
    }
}

