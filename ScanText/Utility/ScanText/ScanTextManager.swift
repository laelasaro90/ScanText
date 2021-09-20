//
//  ScanTextManager.swift
//  ScanText
//
//  Created by Saravanan on 17/09/21.
//

import Foundation
import UIKit
import Vision


class ScanTextManager{
    
    var scannedText :([String]?) -> () = {_ in }
    static let shared: ScanTextManager = {
        let instance = ScanTextManager()
        return instance
    }()
    
    func getTextFromImage(image : UIImage?,scannedText : @escaping ([String]?) -> ()){
        guard let img = image else{
            return
        }
        self.scannedText = scannedText
        // Get the CGImage on which to perform requests.
        guard let cgImage = img.cgImage else { return }

        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)

        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)

        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
  private  func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        // Process the recognized strings.
        processResults(arrText: recognizedStrings)
    }
    
    private  func processResults(arrText : [String]){
        let arrFullText = arrText.compactMap { (strValue) -> [String]? in
                  return strValue.components(separatedBy: " ")
              }
        self.scannedText(arrFullText.reduce([],+))
    }
}
