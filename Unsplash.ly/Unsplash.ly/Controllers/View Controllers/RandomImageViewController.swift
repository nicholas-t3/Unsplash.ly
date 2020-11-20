//
//  RandomImageViewController.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/18/20.
//

import UIKit

class RandomImageViewController: UIViewController {

    var photo: Photo?
    
    @IBOutlet weak var randomImageView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PhotoController.fetchRandomPhotoObject { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photo):
                    self.photo = photo
                    PhotoController.fetchRandomPhoto(photo: photo) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let randomImage):
                                self.randomImageView.image = randomImage
                            case .failure(let error):
                                print (error.localizedDescription)
                            }
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        guard let photo = photo else {return}
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let image = randomImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

           
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        
        PhotoController.fetchRandomPhotoObject { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photo):
                    self.photo = photo
                case .failure(let error):
                    print(error)
                }
            }
        }
        guard let photo = photo else {return}
        
        PhotoController.fetchRandomPhoto(photo: photo) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let randomImage):
                    self.randomImageView.image = randomImage
                case .failure(let error):
                    print (error.localizedDescription)
                }
                
            }
        }
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func randomPhoto() {
        
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
