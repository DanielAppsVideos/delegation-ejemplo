//
//  QuestionsViewController.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 11/08/21.
//

import UIKit

class QuestionsViewController: UIViewController {
//    var currentLevel = 0
    let presenter: QuestionerPresenter = QuestionerPresenter.instance
    var questions: [UIQuestion] = []
    @IBOutlet weak var levelsTableView: UITableView!
    @IBOutlet weak var startRetireButton: UIButton!
    @IBOutlet weak var earnedMoney: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelsTableView.dataSource = self
        levelsTableView.delegate = self
        levelsTableView.register(UINib(nibName: LevelsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: LevelsTableViewCell.identifier)
        presenter.getQuestions(onCompletion: { questionsConverted in
            self.questions = questionsConverted
            print("2. Presenter Callback in viewcontroller: Questions count \(self.questions.count)")
            self.levelsTableView.reloadData()
        }, onError: { error in })
    }
    
    @IBAction func didTapStartRetire(_ sender: UIButton) {
        print("looking if the answer[0] is send back, selected Answer: \(questions[0].selectedAnswer)")
    }
}

extension QuestionsViewController : UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("3. questions count in number of rows: \(questions.count)")
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LevelsTableViewCell.identifier, for: indexPath) as! LevelsTableViewCell
        
        // color gray for cells unselectable
        let isLevelEnable = indexPath.row == presenter.test.currentLevel
        setAsEnabled(cell,enabled:isLevelEnable)
       
        cell.levelLabel.text = "Level \(indexPath.row)"
        guard let wellAnswered = questions[indexPath.row].wellAnswered else {return cell}
        if wellAnswered {
            cell.levelState.image = UIImage(named: "approvedLevelState")
        }else{
            cell.levelState.image = UIImage(named: "rejectedLevelState")
        }
        return cell
    }
    func setAsEnabled(_ cell:LevelsTableViewCell, enabled:Bool){
        
        cell.levelLabel.textColor = enabled ? .black : .lightGray
       
    }
}

extension QuestionsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Questions Table selected row: \(indexPath.row)")
        print("4. Present AnswerVC")
        guard let toAnswerVC = storyboard?.instantiateViewController(identifier: "AnswerViewController") as? AnswerViewController else {return}
        toAnswerVC.question = questions[indexPath.row]
        toAnswerVC.indexPath = indexPath
        toAnswerVC.delegate = self
        
//        toAnswerVC.onAnswer = { question in
//            print("6.callback before dismiss answer window")
//            self.updateInfoAfterAnswer(question, row: indexPath.row)
//        }
        
        self.present(toAnswerVC, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //return what cell is selectable
        return presenter.isSelectableCell(indexPath)
    }
}

extension QuestionsViewController {
    
    func getAnsweredQuestion(_ question: UIQuestion, _ row: Int){
        questions[row] = question
        questions[row].wellAnswered = presenter.validateAnswer(question)
        levelsTableView.reloadData()
        presenter.test.currentLevel += 1
    }
    func updateInfoAfterAnswer(_ question: UIQuestion, row: Int){
        getAnsweredQuestion(question, row)
        guard let answerWasCorrect = questions[row].wellAnswered else {return}
        
        if answerWasCorrect {
            // update progress bar
            ProgressBar.progress += 1/Float(presenter.test.numberOfLevels)
            earnedMoney.text = presenter.calculateEarnedMoney()
            
            // show modal when user wins
            if presenter.didWin() {
                guard let youWinVC = storyboard?.instantiateViewController(identifier: "WonGameViewController") as? WonGameViewController else {return}
                youWinVC.earnedMoney = earnedMoney.text
                self.present(youWinVC, animated: true, completion: nil)
            }
            
        }else{
            // show modal when game over
            if presenter.isStillInGame() {
                presenter.test.shots -= 1
            }else{
                guard let toGameOverVC = storyboard?.instantiateViewController(identifier: "GameOverViewController") as? GameOverViewController else {return}
                self.present(toGameOverVC, animated: true, completion: nil)
            }
        }
    }
}

extension QuestionsViewController:AnswerViewControllerDelegate{
    func userDidAnswer(_ question:UIQuestion, index:IndexPath) {
        print("6.callback before dismiss answer window")
        self.updateInfoAfterAnswer(question, row: index.row)
    }
}
