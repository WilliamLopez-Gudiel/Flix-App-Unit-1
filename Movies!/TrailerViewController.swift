//
//  TrailerViewController.swift
//  Movies!
//
//  Created by William Gudiel on 9/30/20.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    
    var videoKeys = [[String:Any]]()
    var id:Int?
    
    @IBOutlet weak var trailerWebView: WKWebView!
   
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
            trailerWebView = WKWebView(frame: .zero, configuration: webConfiguration)
            trailerWebView.uiDelegate = self
            view = trailerWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id!)/videos?api_key=3ab38ccb961b1f9a4e90350d59729851&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
            self.videoKeys = dataDictionary["results"] as! [[String : Any]]
            
            let key = self.videoKeys[0]["key"]
            let myUrl = URL(string: "https://www.youtube.com/watch?v=\(key!)")
            let myRequest = URLRequest(url: myUrl!)
            DispatchQueue.main.async {
                self.trailerWebView.load(myRequest)
            }
            

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view date
           }
        }
        task.resume()
        
        

        // Do any additional setup after loading the view.
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
