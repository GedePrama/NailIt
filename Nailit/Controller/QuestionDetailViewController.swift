//
//  QuestionDetailViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 12/04/21.
//

import UIKit
import CoreData

class QuestionDetailViewController: UIViewController {
    @IBOutlet weak var imageButton: UIBarButtonItem!
    
    @IBOutlet weak var questionTitle: UILabel!
    
    @IBOutlet weak var detailQuestion1: UILabel!
    
    @IBOutlet weak var detailQuestion2: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var  question = ""
    var questionDetail1 = ""
    var questionDetail2 = ""
    var arrayDetailQuestion = [ListOfQuestion]()
    var bookmark = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTitle.text = question
        detailQuestion1.text = questionDetail1
        detailQuestion2.text = "\(questionDetail2)\(questionDetail2)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if bookmark{
            imageButton.image = UIImage(systemName: "bookmark.fill")
        }
    }
    
    @IBAction func clicked(_ sender: UIBarButtonItem) {
        if imageButton.image == UIImage(systemName: "bookmark.fill"){
            removeFromBookmark()
            imageButton.image = UIImage(systemName: "bookmark")
        } else{
            insertIntoBookmark()
            imageButton.image = UIImage(systemName: "bookmark.fill")
        }
    }
    // tombol bookmark disentuh atas dalam


    
    // MARK: - Set data
    func insertIntoBookmark(){
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
    
    func removeFromBookmark(){
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        request.predicate = NSPredicate(format: "question = %@",question)
        do {
            arrayDetailQuestion = try context.fetch(request)
            arrayDetailQuestion[0].setValue(false, forKey: "bookmark")
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
