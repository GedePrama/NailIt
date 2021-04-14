//
//  HomeViewController.swift
//  Nailit
//
//  Created by Gede Wicaksana on 10/04/21.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var technicalCollectionView: UICollectionView!
    @IBOutlet weak var generalCollectionView: UICollectionView!
    
    //Array untuk collection view
    var technicalImageArray: [UIImage] = [UIImage(#imageLiteral(resourceName: "swift")),UIImage(#imageLiteral(resourceName: "pythonn")),UIImage(#imageLiteral(resourceName: "javaa"))]
    var technicalNameArray = ["Swift","Python","Java"]
    var generalImageArray: [UIImage] = [UIImage(#imageLiteral(resourceName: "character")),UIImage(#imageLiteral(resourceName: "company")),UIImage(#imageLiteral(resourceName: "skill")),UIImage(#imageLiteral(resourceName: "experience")),UIImage(#imageLiteral(resourceName: "teamwork"))]
    var generalNameArray = ["Character","Company","Experience","Skill","Teamwork"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.barTintColor = UIColor.blue
        
        //gajalan ini
        //self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: 200, height: 500)
    }
 
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       navigationController?.navigationBar.prefersLargeTitles = true

       let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.3137254902, blue: 0.7098039216, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

       navigationController?.navigationBar.tintColor = .white
       navigationController?.navigationBar.standardAppearance = appearance
       navigationController?.navigationBar.compactAppearance = appearance
       navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
    // MARK: -Setup Segmented Control
    
    @IBAction func HomeSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            technicalCollectionView.isHidden = false
        } else{
            technicalCollectionView.isHidden = true
        }
    }
    
    
    
    
    
    
    
    // MARK: -Setup Collection View
    
    //return jumlah data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == technicalCollectionView {
            return technicalNameArray.count
        }
        return generalNameArray.count
    }
    
    //return konten
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == technicalCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnicalCollectionViewCell", for: indexPath) as! TechnicalCollectionViewCell
            cell.technicalImage.image = technicalImageArray[indexPath.item]
            cell.technicalLabel.text = technicalNameArray[indexPath.item]
            cell.contentView.layer.cornerRadius = 36.0
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as! GeneralCollectionViewCell
        cell.generalImage.image = generalImageArray[indexPath.item]
        cell.generalLabel.text = generalNameArray[indexPath.item]
        cell.contentView.layer.cornerRadius = 36.0
        return cell
    }
    
    // Kondisi ketika tabel di sentuh atas dalam ()
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = storyboard?.instantiateViewController(identifier: "ListOfQuestionTableViewController") as? ListOfQuestionTableViewController
        if collectionView == technicalCollectionView{
            cell?.category = "Technical"
            cell?.categoryDetail = technicalNameArray[indexPath.item]
        }
        else{
            cell?.category = "General"
            cell?.categoryDetail = generalNameArray[indexPath.item]
        }
        //cara lain untuk perform segue
        //performSegue(withIdentifier: "goToListOfQuestion", sender: self)
        self.navigationController?.pushViewController(cell!, animated: true)
    }
        
      
}
