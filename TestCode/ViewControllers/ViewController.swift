//
//  ViewController.swift
//  TestCode
//
//  Created by Interview on 12/10/19.
//  Copyright © 2019 Interview. All rights reserved.
//

import UIKit


// Test Commit
class ViewController: UIViewController {

    var photos = [PhotoCodable]()
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var currentPage = 1
    var currentText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Register UITableViewCell..
        self.tblView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "cellid")
    }
    
    func initatePhotoFetchCall(withText text:String){
        showLoader()
        NetworkHelper.shared.getPhotos(text: text, pageNumber: currentPage) { [weak self] (res, err) in
            self?.hideLoader()
            if let error = err{
                print("There is error: \(error)")
            }
            if let fetchedPhotos = res{
                self?.currentPage  = self?.currentPage ?? 0 + 1
                print("fetchedPhotos: \(fetchedPhotos)")
                self?.photos.append(contentsOf: fetchedPhotos)
                self?.tblView.reloadData()
            }
        }

    }
    
    
    func showLoader(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
   func hideLoader(){
    dismiss(animated: false, completion: nil)
    }
}



extension ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text enterd :\(textField.text!))")
        currentText = textField.text!
        photos.removeAll()
        initatePhotoFetchCall(withText: currentText)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }

}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as? PhotoCell {
            let photo = photos[indexPath.row]
            let completeImgUrl = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
            cell.imageCompleteNameLabel.text = completeImgUrl
            
            let queue = DispatchQueue.global(qos: .default)
            queue.async {
                let imageDownloader = ImageDownloader()
                guard let url = URL(string: completeImgUrl) else { return  }
                imageDownloader.downloadImage(from: url) {(img, err) in
                    if let image = img {
                        DispatchQueue.main.async {
                            if let cell = tableView.cellForRow(at: indexPath) as? PhotoCell{
                                cell.serachedImage.image = nil
                                cell.serachedImage.image = image
                            }
                        }
                    }
                }
            }
            return cell
        }else{
           return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = photos.count - 1
        if  indexPath.row == lastElement {
            initatePhotoFetchCall(withText: currentText)
        }
    }

}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let completeImgUrl = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        print("completeImgUrl ; \(completeImgUrl)")
    }
    
}


