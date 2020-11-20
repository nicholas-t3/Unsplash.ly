//
//  TopicCollectionViewController.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/19/20.
//

import UIKit

class TopicCollectionViewController: UIViewController {
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var topicName: String?
    
    var topicPhotos: [PhotoFromTopic] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let topicNameLowercased = topicName?.lowercased() else {return}
        
        guard let topicName = topicName else {return}
        topicLabel.text = topicName
        
        PhotoFromTopicController.fetchPhotosFromTopic(topicName: topicNameLowercased) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let topicPhotos):
                    self.topicPhotos = topicPhotos
                    print("SUCCESSSS")
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
        }
        
        
        collectionView.register(TopicCollectionViewCell.nib(), forCellWithReuseIdentifier: "TopicCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension TopicCollectionViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Item tapped!")
    }
}
extension TopicCollectionViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCollectionViewCell", for: indexPath) as? TopicCollectionViewCell else {return UICollectionViewCell()}
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        //if topicPhotos.count >= 1 {
            let topicPhotoPhoto = topicPhotos[indexPath.item]
            
            PhotoFromTopicController.fetchImages(photoFromTopic: topicPhotoPhoto) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        cell.imageView.image = image
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            return cell
        //} else {return cell}
        
    }

}

extension TopicCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 1) // 15 because of paddings
       
        return CGSize(width: width, height: 200)
    }
}

