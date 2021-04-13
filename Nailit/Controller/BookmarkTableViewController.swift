//
//  BookmarkTableViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 13/04/21.
//

import UIKit
import CoreData

class BookmarkTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayBookmark = [ListOfQuestion]()
    var bo = true
    var select = 0
    var selected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBookmark()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBookmark.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath)
        cell.textLabel?.text = arrayBookmark[indexPath.row].question
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove", handler: { (action, view, onComplete) in
            tableView.beginUpdates()
            self.select = indexPath.row
            self.removeFromBookmark()
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.loadBookmark()
            tableView.endUpdates()
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "goToNote", sender: self)
//        selected = indexPath.row
        let cell = storyboard?.instantiateViewController(identifier: "NoteViewController") as? NoteViewController
        cell?.question = arrayBookmark[indexPath.row].question!
        cell?.note = arrayBookmark[indexPath.row].notes!
        self.navigationController?.pushViewController(cell!, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? NoteViewController {
//            print(select)
//            print(selected)
//            destination.question = arrayBookmark[selected].question!
//            destination.note = arrayBookmark[selected].notes!
//        }
//    }
    
    
    func loadBookmark(){
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        let bookmarkPredicate = NSPredicate(format: "bookmark == %d", bo)
        request.predicate = bookmarkPredicate
        request.sortDescriptors = [NSSortDescriptor(key: "question", ascending: true)]
        
        do {
            arrayBookmark = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    func removeFromBookmark(){
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        request.predicate = NSPredicate(format: "question = %@",arrayBookmark[select].question!)
        do {
            arrayBookmark = try context.fetch(request)
            arrayBookmark[0].setValue(false, forKey: "bookmark")
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
