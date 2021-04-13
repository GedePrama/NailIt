//
//  NoteDetailViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 13/04/21.
//

import UIKit
import CoreData

class NoteDetailViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionDetail1: UITextView!
    @IBOutlet weak var questionDetail2: UITextView!
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayNoteDetail = [ListOfQuestion]()
    var question = ""
    var questionDetailVariable1 = ""
    var questionDetailVariable2 = ""

    
    
    override func viewWillAppear(_ animated: Bool) {
        load()
        questionLabel.text = question
        questionDetail1.text = questionDetailVariable1
        questionDetail2.text = questionDetailVariable2
    }

    func load(){
        
        //Cari dulu berdasarkan nspredicatenya
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        
        request.predicate = NSPredicate(format: "question = %@",question)
        
        do {
            arrayNoteDetail = try context.fetch(request)
            questionDetailVariable1 = arrayNoteDetail[0].questionDetail1!
            questionDetailVariable2 = arrayNoteDetail[0].questionDetail2!
            
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        //Save
        do {
            try context.save()
        } catch {
            print("Error saving content: \(error)")
        }
    }

}
