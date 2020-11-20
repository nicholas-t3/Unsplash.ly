//
//  TopicTableView.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/18/20.
//

import UIKit

class TopicTableView: UITableView, UITableViewDelegate {

    var topics: [Topic] = []
    
    func viewDidLoad() {
       viewDidLoad()

        TopicController.fetchTopic { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let topics):
                    self.topics = topics
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topics.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TopicTableViewCell else {return UITableViewCell()}
        
        let topic = topics[indexPath.row]
        cell.selectionStyle = .none
        
        cell.topicLabel.text = topic.title

        // Configure the cell...

        return cell
    }
    
    

    
}
