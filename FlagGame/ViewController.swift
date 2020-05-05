//
//  ViewController.swift
//  FlagGame
//
//  Created by Александра Наврузова on 26.03.2020.
//  Copyright © 2020 Alexandra Navruzova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    let questionsLimit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor


        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "counter"), style: .plain, target: self, action: #selector(addTapped))

    }
    
    func askQuestion(_ action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) - Score is \(score)"
    }
    
    func endGame(_ action: UIAlertAction!) {
        score = 0
        questionsAsked = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        questionsAsked += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "That's the flag of \(countries[sender.tag].uppercased())"
            
        } else {
            title = "Wrong"
            score -= 1
            message = "That's the flag of \(countries[sender.tag].uppercased())"
            
        }
        let ac: UIAlertController!
        
        if questionsAsked == questionsLimit {
            ac = UIAlertController(title: "That's the flag of \(countries[sender.tag].uppercased())", message: "You have answered \(questionsAsked) questions with the score \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: endGame))
        } else {
            ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
    }
    @objc func addTapped() {
        let ac = UIAlertController(title: "Your current score is \(score)", message: "Let's continue the game!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }

    
}

