//
//  QuestionDetailViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 12/04/21.
//

import UIKit
import CoreData

class QuestionDetailViewController: UIViewController {
    
    @IBOutlet weak var questionTitle: UILabel!
    
    @IBOutlet weak var detailQuestion1: UILabel!
    
    @IBOutlet weak var detailQuestion2: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var  question = ""
    var questionDetail1 = ""
    var questionDetail2 = ""
    var arrayDetailQuestion = [ListOfQuestion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTitle.text = question
        detailQuestion1.text = questionDetail1
        detailQuestion2.text = "\(questionDetail2)\(questionDetail2)"
    }
    
    // tombol bookmark disentuh atas dalam
    @IBAction func bookmarkButtonOnClick(_ sender: UIBarButtonItem) {
        InsertIntoBookmark()
    }
    

    
    // MARK: - Set data
    func InsertIntoBookmark(){
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        request.predicate = NSPredicate(format: "question = %@",question)
        do {
            arrayDetailQuestion = try context.fetch(request)
            arrayDetailQuestion[0].setValue(true, forKey: "bookmark")
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving content: \(error)")
        }
    }
    
    
}
