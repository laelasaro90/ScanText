//
//  ResutView.swift
//  ScanText
//
//  Created by Saravanan on 17/09/21.
//

import Foundation
import UIKit

class ResultView : UIView{
    var selectedText :(String?) -> () = {_ in }
    
    var arrString : [String]?
    var tblView = UITableView()
    //initWithFrame to init view from code
      override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
      }
      
      //initWithCode to init view from xib or storyboard
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
      }
      
      //common func to init our view
      private func setupView() {
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true

        self.addSubview(tblView)
        tblView.delegate = self
        tblView.dataSource = self
        tblView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
            NSLayoutConstraint.activate(attributes.map {
                NSLayoutConstraint(item: tblView, attribute: $0, relatedBy: .equal, toItem: tblView.superview, attribute: $0, multiplier: 1, constant: 0)
            })
      }
    
    func showView(selectedTextValue : @escaping (String?) -> ()){
        selectedText = selectedTextValue
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
    }
}

extension ResultView{
    convenience init(fram: CGRect, arrText :[String]) {
        self.init(frame: fram)
        arrString = arrText
    }
}

extension ResultView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedText(arrString?[indexPath.row])
    }
}


extension ResultView : UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrString?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTweets") else {
                        return UITableViewCell(style: .default, reuseIdentifier: "cellTweets")
                        }
                        return cell
                    }()
        cell.textLabel?.text = arrString?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please select the text"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}



