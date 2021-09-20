//
//  ViewController.swift
//  ScanText
//
//  Created by Saravanan on 17/09/21.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    
    @IBOutlet var vwWordsDetails: UIView!
    @IBOutlet var lblThresaurus: UILabel!
    @IBOutlet var lblAntonyms: UILabel!
    @IBOutlet var lblSynonyms: UILabel!
    @IBOutlet var tblVwTweets: UITableView!
    
    var viewModel : HomeProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        // Do any additional setup after loading the view.
    }
    @IBAction func onScan(_ sender: Any) {
        ImagePicker.shared.present(presentationController: self) { (scannedImage) in
            if let img = scannedImage{
                self.findTextFromImage(image: img)
            }
        }
    }
    
}

/* Find text from image*/
extension ViewController {
    
    func findTextFromImage(image : UIImage){
        
        ScanTextManager.shared.getTextFromImage(image: image) { [weak self]  (arrText) in
            DispatchQueue.main.async {
                guard let strongSelf = self else{
                    return
                }
                guard let arrTexts = arrText else{
                    return
                }
                strongSelf.showScannedResult(arrText: arrTexts)
            }
            
        }
    }
    
    func showScannedResult(arrText : [String]){
        let vw = ResultView(fram: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height:  UIScreen.main.bounds.height / 1.5), arrText: arrText)
        
        vw.center = self.view.center
        self.view.addSubview(vw)
        vw.showView { [weak self] (choosedText) in
            guard let strongSelf = self else{
                return
            }
            vw.removeFromSuperview()
            strongSelf.doProcess(text: choosedText)
        }
    }
    func doProcess(text : String?){
        guard let selectedText = text else{return}
        self.title = selectedText
        print(selectedText)
        self.viewModel.getAllDetails(word: selectedText)
    }
}

extension ViewController {
    func setupUI(){
        vwWordsDetails.isHidden = true
        tblVwTweets.delegate = self
        tblVwTweets.dataSource = self
        tblVwTweets.tableFooterView = UIView()
        tblVwTweets.rowHeight = UITableView.automaticDimension;
        tblVwTweets.estimatedRowHeight = UITableView.automaticDimension;
        
    }
    func setupViewModel(){
        viewModel.reloadView = { isReloadView in
            
            DispatchQueue.main.async {
               
                self.tblVwTweets.reloadData()
                self.updateUI()
            }
        }
        viewModel.isLoading = {[weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading{
                    self?.showLoader()
                }else{
                    self?.hideLoader()
                }
            }
        }
    }
    func updateUI(){
        guard let wordResponse = self.viewModel.wordResponse  else {
            return
        }
        vwWordsDetails.isHidden = false
        
        lblSynonyms.text = wordResponse.arrSynonyms?.count ?? 0 > 0 ? wordResponse.arrSynonyms?.joined(separator: ", ") : "NA"
        
        lblAntonyms.text = wordResponse.arrAntonyms?.count ?? 0 > 0 ? wordResponse.arrAntonyms?.joined(separator: ", ") : "NA"
        
        
        lblThresaurus.text = wordResponse.arrThesaurus?.count ?? 0 > 0 ? wordResponse.arrThesaurus?.joined(separator: ", ") : "NA"
            
    }
    
    func showLoader(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    func hideLoader(){
        dismiss(animated: false, completion: nil)
    }
}


extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.twitterResponse?.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTweets") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cellTweets")
                }
                return cell
            }()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = self.viewModel.twitterResponse?.rows?[indexPath.row].descript
        return cell
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tweets"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.twitterResponse?.rows == nil ? 0 : 1
    }
    
}
