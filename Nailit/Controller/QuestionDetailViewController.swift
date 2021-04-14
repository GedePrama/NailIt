//
//  QuestionDetailViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 12/04/21.
//

import UIKit
import CoreData
import AVFoundation
import AVKit

class QuestionDetailViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var bookmarkLogo: UIBarButtonItem!
    
    @IBOutlet weak var questionTitle: UILabel!
    
    @IBOutlet weak var detailQuestion1: UILabel!
    
    @IBOutlet weak var detailQuestion2: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var  question = ""
    var questionDetail1 = ""
    var questionDetail2 = ""
    var arrayDetailQuestion = [ListOfQuestion]()
    var bookmark = false
    var videoLink = ""
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        questionTitle.text = question
        detailQuestion1.text = questionDetail1
        detailQuestion2.text = questionDetail2
        if videoLink != ""{
            let moviePath = Bundle.main.path(forResource: videoLink, ofType: "mp4")
            if let path = moviePath {
                let url = NSURL.fileURL(withPath: path)
                self.player = AVPlayer(url: url)
                self.avpController = AVPlayerViewController()
                self.avpController.player = self.player
                avpController.view.frame = videoView.frame
                self.addChild(avpController)
                self.view.addSubview(avpController.view)
            }
       }
       // Do any additional setup after loading the view.
   }
    
    override func viewWillAppear(_ animated: Bool) {
        if bookmark{
            bookmarkLogo.image = UIImage(systemName: "bookmark.fill")
        }
    }
    
    @IBAction func clicked(_ sender: UIBarButtonItem) {
        if bookmarkLogo.image == UIImage(systemName: "bookmark.fill"){
            removeFromBookmark()
            bookmarkLogo.image = UIImage(systemName: "bookmark")
        } else{
            insertIntoBookmark()
            bookmarkLogo.image = UIImage(systemName: "bookmark.fill")
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
