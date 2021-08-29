//
//  AnswerViewController.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 17/08/21.
//

import UIKit

protocol AnswerViewControllerDelegate:AnyObject {
    func userDidAnswer(_ question:UIQuestion, index:IndexPath)
}

class AnswerViewController: UIViewController {
    
    var onAnswer: ((_ question: UIQuestion)->Void)?
    var indexPath:IndexPath!
    weak var delegate:AnswerViewControllerDelegate?
    
    var question: UIQuestion = UIQuestion(question: "", answers: [], correctAnswer: "")
    @IBOutlet weak var AnswersTableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        AnswersTableView.delegate = self
        AnswersTableView.dataSource = self
        print("5. AnswerVC question: \(question.question)")
        AnswersTableView.register(UINib(nibName: AnswerTableViewCell.nib, bundle: nil), forCellReuseIdentifier: AnswerTableViewCell.identifier)
        AnswersTableView.rowHeight = UITableView.automaticDimension
        AnswersTableView.estimatedRowHeight = 50
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 10
        questionLabel.text = question.question
    }
    
    @IBAction func didTapConfirm(_ sender: UIButton){
        print("7. dismiss answer window and pass info")
        //onAnswer?(question)
        delegate?.userDidAnswer(question,index: self.indexPath)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension AnswerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // preguntar guard let
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.identifier, for: indexPath) as! AnswerTableViewCell
        cell.answerOption.text = question.answers[indexPath.row]
        cell.minHeight = 50
            return cell
    } 
}

extension AnswerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("5.1. AnswerTableview cell selected: \(indexPath.row)")
        question.selectedAnswer = question.answers[indexPath.row]
        print("5.2. The selected Answer is: \(question.selectedAnswer)")
    }
}
