//
//  GamingViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 20.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGGamingViewController: UIViewController {
    
    @IBOutlet weak var upperButton: PNTButton!
    @IBOutlet weak var rightButton: PNTButton!
    @IBOutlet weak var leftButton: PNTButton!
    @IBOutlet weak var lowerButton: PNTButton!
    
    @IBOutlet weak var centralSearchField: UITextField!
    @IBOutlet weak var leftSearchField: UITextField!
    @IBOutlet weak var rightSearchField: UITextField!
    @IBOutlet weak var hiddenSearchField: UITextField!
    
    @IBOutlet weak var progressBar: LGProgressBar!
    
    var touchedAnswerButton : PNTButton!
    
    var timer : NSTimer!
    var time : Float = 60
    
    var model : NSMutableArray = []
    var roundCounter : Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup triangle buttons
        let buttons : NSArray = [upperButton,rightButton,leftButton,lowerButton]
        let utility : PNTUtility = PNTUtility.sharedUtility()
        utility.buttons = buttons;
        
        model = Word.getWords(0, lesson: 0, nativeLanguage: "", foreignLanguage: "")
        roundCounter = 0
        
        //set searchWordFields for the first time
        self.centralSearchField.text = (model[roundCounter][0] as Word).en
        self.rightSearchField.text = (model[roundCounter+1][0] as Word).en
        
        updateAnswerButtons()
    
        progressBar.percent = 1;
        
        timer = NSTimer(timeInterval: 1, target: self, selector: "timerDidFire:", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    func timerDidFire(timer:NSTimer!)
    {
        time -= 1
        progressBar.percent = time / 60.0;
    }
    
    @IBAction func answerButtonPressed(sender: PNTButton) {
        
        //for setting color in triangle buttons
        sender.isCorrectClick = sender.tag == 1
        sender.willAnimate = true
        sender.setNeedsDisplay()
        
        touchedAnswerButton = sender
        
        updateSearchFieldViews()
    }
    
    func updateAnswerButtons()
    {
        var indices : Array = [Int]()
        indices = [0,1,2,3]
        indices = shuffle(indices)
        
        upperButton.setTitle((model[roundCounter][indices[0]] as Word).de, forState: UIControlState.Normal)
        upperButton.tag = (indices[0] == 0 ? 1 : 0)
        leftButton.setTitle((model[roundCounter][indices[1]] as Word).de, forState: UIControlState.Normal)
        leftButton.tag = (indices[1] == 0 ? 1 : 0)
        rightButton.setTitle((model[roundCounter][indices[2]] as Word).de, forState: UIControlState.Normal)
        rightButton.tag = (indices[2] == 0 ? 1 : 0)
        lowerButton.setTitle((model[roundCounter][indices[3]] as Word).de, forState: UIControlState.Normal)
        lowerButton.tag = (indices[3] == 0 ? 1 : 0)
    }
    
    func shuffle<T>(var list: Array<T>) -> Array<T> {
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    func updateSearchFieldViews()
    {
        self.hiddenSearchField.text = (model[roundCounter+2][0] as Word).en
        
        UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseIn, animations: {
            var newFrame = CGRectMake(self.leftSearchField.frame.origin.x - self.leftSearchField.frame.size.width/2, self.leftSearchField.frame.origin.y, self.leftSearchField.frame.size.width, self.leftSearchField.frame.size.height)
            self.leftSearchField.frame = newFrame

            newFrame = CGRectMake(self.centralSearchField.frame.origin.x - self.centralSearchField.frame.size.width/2, self.centralSearchField.frame.origin.y, self.centralSearchField.frame.size.width, self.centralSearchField.frame.size.height)
            self.centralSearchField.frame = newFrame
            
            newFrame = CGRectMake(self.rightSearchField.frame.origin.x - self.rightSearchField.frame.size.width/2, self.rightSearchField.frame.origin.y, self.rightSearchField.frame.size.width, self.rightSearchField.frame.size.height)
            self.rightSearchField.frame = newFrame
            
            newFrame = CGRectMake(self.hiddenSearchField.frame.origin.x - self.hiddenSearchField.frame.size.width/2, self.hiddenSearchField.frame.origin.y, self.hiddenSearchField.frame.size.width, self.hiddenSearchField.frame.size.height)
            self.hiddenSearchField.frame = newFrame
            
            }, completion: { finished in
                println("Basket doors opened!")
                self.roundCounter++;
                self.updateSearchFieldFrames()
                self.updateAnswerButtons()
        })
    }
    
    func updateSearchFieldFrames()
    {
        self.leftSearchField.text = self.centralSearchField.text;
        self.leftSearchField.frame = self.centralSearchField.frame;
        self.centralSearchField.text = self.rightSearchField.text;
        self.centralSearchField.frame = self.rightSearchField.frame;
        self.centralSearchField.textColor = self.rightSearchField.textColor;
        self.rightSearchField.text = self.hiddenSearchField.text;
        self.rightSearchField.frame = self.hiddenSearchField.frame;
        self.rightSearchField.textColor = self.hiddenSearchField.textColor;
        self.hiddenSearchField.frame = CGRectMake(self.hiddenSearchField.frame.size.width, 0, self.hiddenSearchField.frame.size.width, self.hiddenSearchField.frame.size.height);
    
        //unset color of touched button
        touchedAnswerButton.willAnimate = false;
        touchedAnswerButton.setNeedsDisplay();
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
