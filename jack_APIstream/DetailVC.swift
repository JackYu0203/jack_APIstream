//
//  DetailVC.swift
//  jack_APIstream
//
//  Created by JackYu on 2021/3/2.
//

import UIKit
import CryptoKit
import Foundation
import Kingfisher

class DetailVC: UIViewController {
    
    var characterId: Int = 0
    var Item = [results]()
    var Description: String = ""
    
    

    @IBOutlet weak var DetailText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStories()
        print("DetailVC:\(characterId)")
        print("description" + "\(Item.description)")
        
        DetailText?.text = Item.description
    }
    
    
        func getStories(){
    
            let ts = Date().timeIntervalSinceReferenceDate
            let privateKey = "2316edb8da124bdc1800fb2edbd9d1275791f424"
            let publicKey = "2ec355e2647d84553c09d7083e8fcfd2"
            let md5InputData = "\(ts)\(privateKey)\(publicKey)".data(using: .utf8)!
            let digest = Insecure.MD5.hash(data: md5InputData)
            let hashString = digest.map {
                String(format: "%02x", $0)
            }.joined()
        
   
            let urlString = "https://gateway.marvel.com/v1/public/characters/\(characterId)/stories?ts=\(ts)&apikey=\(publicKey)&hash=\(hashString)"
            
            print(urlString)
    
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data{
                        let decoder = JSONDecoder();
                        decoder.dateDecodingStrategy = .iso8601
    
                        do {
                            let stories = try decoder.decode(Stories.self, from: data)
                            self.Item = stories.data.results
                            print("\(stories.data.results)")
                            
                            self.Description = stories.data.results.description
                            
                            DispatchQueue.main.async {
                                if stories.data.results[0].description != ""{
                                    self.DetailText.text = stories.data.results[0].description
                                }
                                else{
                                    self.DetailText.text = "This Character hasn't any stories!"
                                }
                            }
    
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
            }
    
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
