//
//  TableViewController.swift
//  jack_APIstream
//
//  Created by JackYu on 2021/3/1.
//

import UIKit
import CryptoKit
import Foundation
import Kingfisher

class TableViewController: UITableViewController {
    
    var Item = [Results]()
    var charactername: String = ""
    
    func getCharacter() {
        
        let ts = Date().timeIntervalSinceReferenceDate
        let privateKey = "2316edb8da124bdc1800fb2edbd9d1275791f424"
        let publicKey = "2ec355e2647d84553c09d7083e8fcfd2"
        let md5InputData = "\(ts)\(privateKey)\(publicKey)".data(using: .utf8)!
        let digest = Insecure.MD5.hash(data: md5InputData)
        let hashString = digest.map {
            String(format: "%02x", $0)
        }.joined()
        
        
        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hashString)"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data{
                    let decoder = JSONDecoder();
                    decoder.dateDecodingStrategy = .iso8601
                    
                    do {
                        let character = try decoder.decode(Character.self, from: data)
                        
                        self.Item = character.data.results
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        //印印看有沒有東西
                        let results = character.data.results[3]
                        print(results.name)
                        print(results.thumbnail)
                        
                        //cell.textLabel?.text = results.name
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacter()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)", for: indexPath) as! TableViewCell
        
        
        let item = Item[indexPath.row]
        
        
        let url =  URL(string : "\(item.thumbnail.path)" + "/" + "portrait_xlarge" + "." + "\(item.thumbnail.extension)" )
        
        // 把url從http轉https
        var urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        
        charactername = item.name
        cell.nameLabel?.text = item.name
        cell.pictureView.kf.setImage(with: urlComponents?.url!)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let characterId = Item[indexPath.row]
            let detailVC = segue.destination as! DetailVC
            detailVC.characterId = characterId.id
            print("\(characterId.id)")
        }
       
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
