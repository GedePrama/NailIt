//
//  StartSimulationViewController.swift
//  NailIt
//
//  Created by Dicky Buwono on 12/04/21.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AVKit
import CoreData

class StartSimulationViewController: UIViewController {
   // @IBOutlet weak var fotoDicky: UIImageView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arraySimulation = [ListOfQuestion]()
    var botrue = true
    var i = 0
    
    let imagePickerController = UIImagePickerController()
    var videoURL : URL?

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @objc func video(
      _ videoPath: String,
      didFinishSavingWithError error: Error?,
      contextInfo info: AnyObject
    ) {
      let title = (error == nil) ? "Success" : "Error"
      let message = (error == nil) ? "Video was saved" : "Video failed to save"

      let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert)
      alert.addAction(UIAlertAction(
        title: "OK",
        style: UIAlertAction.Style.cancel,
        handler: nil))
      present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadSimulation()
        if arraySimulation.count != 0{
            questionLbl.text = arraySimulation[0].question!
        }else{
            questionLbl.text = "There is no question"
        }
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
    }
    
    
    @IBAction func record(_ sender: AnyObject) {
        //UIView.animate(withDuration: 3, animations: {
        //    self.fotoDicky.frame.origin.y -= 400
        //}, completion: nil)
        i += 1
        if i < arraySimulation.count{
            VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera)
        }else{
            startButton.setTitle("Finish", for: .normal)
            navigationController?.popViewController(animated: true)
        }
        
    }

    @IBAction func nextQuestion(_ sender: UIButton) {
        print("button click")
        i += 1
        if i < arraySimulation.count{
            UIView.transition(with: questionLbl,
                              duration: 0.5,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                            self?.questionLbl.text = self?.arraySimulation[self!.i].question
                     }, completion: nil)
        }
        else{
            questionLbl.text = "Finish"
        }
    }
  
    //
    /*
    @IBAction func recordAct(_ sender: UIButton) {
      /* if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            print("Camera Available")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera UnAvailable")
        }*/
        
        
    }
    /*
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaURL] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else {
                return
        }
        // Handle a movie capture
        UISaveVideoAtPathToSavedPhotosAlbum(
            url.path,
            self,
            #selector(video(_:didFinishSavingWithError:contextInfo:)),
            nil)
    }*/
    /*
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video failed to save"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        print("\(String(describing: videoURL))")
        self.dismiss(animated: true, completion: nil)
    }*/*/
    
    
    
   

}

// MARK: - UIImagePickerControllerDelegate


extension StartSimulationViewController: UIImagePickerControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    dismiss(animated: true, completion: nil)

    guard
      let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
      mediaType == (kUTTypeMovie as String),
      let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
      UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
      else { return }

    // Handle a movie capture
    UISaveVideoAtPathToSavedPhotosAlbum(
      url.path,
      self,
      #selector(video(_:didFinishSavingWithError:contextInfo:)),
      nil)
  }
}

// MARK: - UINavigationControllerDelegate
extension StartSimulationViewController: UINavigationControllerDelegate {
    
}
