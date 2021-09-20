//
//  HomeViewModel.swift
//  ScanText
//
//  Created by Saravanan on 20/09/21.
//

import Foundation
protocol HomeProtocol {
    var twitterResponse : TwiiterResponse? { get set}
    var wordResponse : WordResponse? { get set}
    var reloadView: ((_ reloadFullView : Bool) -> ())? { get set }
    func getAllDetails(word : String)
    var isLoading: ((_ isLoadView : Bool) -> ())? { get set }
}

class HomeViewModel : HomeProtocol{
    var isLoading: ((Bool) -> ())?
    
    var searchWord : String?
    
    func getAllDetails(word: String) {
        searchWord = word
        DispatchQueue.global().async {
            self.isLoading?(true)
            let dispatchGroup = DispatchGroup()
            
            // Get word details from wordAPI
            dispatchGroup.enter()
            self.getWordDetails {
                dispatchGroup.leave()
            } failed: {
                dispatchGroup.suspend()
            }
            dispatchGroup.wait()
            
            
            //Get tweets details from twinesocial
            dispatchGroup.enter()
            self.getTweets {
                dispatchGroup.leave()
            } failed: {
                dispatchGroup.suspend()
            }
            dispatchGroup.wait()
            
            dispatchGroup.notify(queue: .main) {
                self.isLoading?(false)
                self.reloadView?(true)
            }
        }
    }
    
    var twitterResponse: TwiiterResponse?
    var wordResponse: WordResponse?
    var reloadView: ((Bool) -> ())?
    private let pageLimt = 10
    
    private func getWordDetails(success: @escaping () -> Void,failed: @escaping () -> Void){
        let headers = [
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com",
            "x-rapidapi-key": "wWehAfEKenmshmCBrLwcyhZRM37vp1FlKfBjsnec3FNH1n3qCM"
        ]
        
        guard let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(searchWord ?? "")") else {
            failed()
            return
        }
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                if (error != nil) {
                    print(error?.localizedDescription)
                    failed()
                } else {
                    do{
                        guard  let responseData = data else {
                            return
                        }
                        self.wordResponse = try JSONDecoder().decode(WordResponse.self, from: responseData)
                        success()
                    }catch(let err){
                        print(err.localizedDescription)
                        failed()
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    func getTweets(success: @escaping () -> Void,failed: @escaping () -> Void){
        let headers = [
            "x-rapidapi-host": "twinesocial.p.rapidapi.com",
            "x-rapidapi-key": "wWehAfEKenmshmCBrLwcyhZRM37vp1FlKfBjsnec3FNH1n3qCM"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://twinesocial.p.rapidapi.com/v1/content?campaign=louboutin")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                if (error != nil) {
                    print(error)
                    failed()
                } else {
                    
                    do{
                        guard  let responseData = data else {
                            return
                        }
                        self.twitterResponse = try JSONDecoder().decode(TwiiterResponse.self, from: responseData)
                        success()
                    }catch(let err){
                        print(err.localizedDescription)
                        failed()
                    }
                }
            }
        })
        dataTask.resume()
    }
}
