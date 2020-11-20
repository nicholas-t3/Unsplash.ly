//
//  TopicsViewController.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/18/20.
//

import UIKit

class TopicsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var topicTableView: UITableView!
    
    var topics: [Topic] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        topicTableView.delegate = self
        topicTableView.dataSource = self
        topicTableView.backgroundColor = UIColor.clear
       TopicController.fetchTopic { (result) in
        
            DispatchQueue.main.async {
                switch result {
                case .success(let topics):
                    self.topics = topics
                    self.topicTableView.reloadData()
                    print(topics)
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    
    
    
    
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTopicVC"{
            guard let indexPath = topicTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? TopicCollectionViewController else {return}
            
            let topicName = topics[indexPath.row].title
            
            destinationVC.topicName = topicName
            
            
        }
        
    }
    

    

} // End of class 

extension TopicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(topics.count)
        return topics.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as? TopicTableViewCell else { return UITableViewCell()}

        let topic = topics[indexPath.row]
        print("Current index path: \(topics[indexPath.row])")
        print("Topics array: \(self.topics)")
        cell.topicLabel?.text = topic.title
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.topicCoverImage.makeRounded()
        
        
        TopicController.fetchCoverPhoto(topic: topic) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    cell.topicCoverImage.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
        return cell
        
    }
    

    
    
}


extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
