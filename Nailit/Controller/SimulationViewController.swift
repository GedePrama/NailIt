//
//  SimulationViewController.swift
//  NailIt
//
//  Created by Roshani Ayu Pranasti on 09/04/21.
//

import UIKit
import AVKit
import MobileCoreServices
import CoreData

class SimulationViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arraySimulation = [ListOfQuestion]()
    
    @IBOutlet weak var simulationTableView: UITableView!


    var botrue = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        simulationTableView.delegate = self
        simulationTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSimulation()
    }
    
    
    @IBAction func playVideo(_ sender: AnyObject) {
      VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }


}

extension SimulationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return arraySimulation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let aboutSimulationCell = tableView.dequeueReusableCell(withIdentifier: "aboutSimulation", for: indexPath) as! AboutSimulationTableViewCell
            aboutSimulationCell.startSimulationButton.layer.cornerRadius = 8
            
            return aboutSimulationCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listOfQuestions", for: indexPath)
        cell.textLabel?.text = arraySimulation[indexPath.row].question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
            let listLabel = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 44))
            listLabel.text = "LIST OF QUESTIONS"
            listLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
            listLabel.textColor = UIColor.gray
            view.addSubview(listLabel)
            
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 36
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return simulationTableView.sectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 354
        }
        
        return UITableView.automaticDimension
    }
    
    
    func loadSimulation(){
        let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
        let bookmarkPredicate = NSPredicate(format: "bookmark == %d", botrue)
        request.predicate = bookmarkPredicate
        request.sortDescriptors = [NSSortDescriptor(key: "question", ascending: true)]
        
        do {
            arraySimulation = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        simulationTableView.reloadData()
    }
  
}

















extension SimulationViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
      // 1
      guard
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
        mediaType == (kUTTypeMovie as String),
        let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        else { return }

      // 2
      dismiss(animated: true) {
        //3
        let player = AVPlayer(url: url)
        let vcPlayer = AVPlayerViewController()
        vcPlayer.player = player
        self.present(vcPlayer, animated: true, completion: nil)
      }
    }
    
}

// MARK: - UINavigationControllerDelegate
extension SimulationViewController: UINavigationControllerDelegate {
    
    
}
