//
//  NoteViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 12/04/21.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    @IBOutlet weak var detailQuestionTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var arrayNotes = [ListOfQuestion]()
    
    var question = ""
    var note = ""
  
    override func viewWillAppear(_ animated: Bool) {
        detailQuestionTableView.reloadData()
    }
    
    //Button submit
    
    
    
    
    
    
    
    
    func saveNote(noteDone: String){
        
        //Cari dulu berdasarkan nspredicatenya
        
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        
        request.predicate = NSPredicate(format: "question = %@",question)
        
        do {
            arrayNotes = try context.fetch(request)
            arrayNotes[0].setValue(noteDone, forKey: "notes")
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

extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        if indexPath.section == 1 {
            let notesCell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NotesTableViewCell
            notesCell.notesTextView.delegate = self
            if note == "" {
                notesCell.notesTextView.text = "Write your notes here"
                notesCell.notesTextView.textColor = UIColor.lightGray
            } else {
                notesCell.notesTextView.text = note
        }
            return notesCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionExplanation", for: indexPath)
            cell.textLabel?.text = question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return detailQuestionTableView.sectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 215
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = storyboard?.instantiateViewController(identifier: "NoteDetailViewController") as? NoteDetailViewController
        cell?.question = question
        self.navigationController?.pushViewController(cell!, animated: true)
    }
    
    
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        saveNote(noteDone: textView.text)
    }

//    func textViewDidChange(_ textView: UITextView) {
//        print("Value berubah")
//        // TODO: ubah value di data
//    }
}
