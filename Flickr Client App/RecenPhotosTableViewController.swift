//
//  ViewController.swift
//  Flickr Client App
//
//  Created by mustafa yildiz on 28.08.2022.
//

import UIKit

class RecenPhotosTableViewController: UITableViewController, UISearchResultsUpdating {
   
    private var photosResponse: PhotosResponse? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchingSetup()
        fetchRecentPhotos()
        
        
    }
       
    private func fetchRecentPhotos(){
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=4db403543040033253f3652e32ddb5d4&format=json&nojsoncallback=1&extras=description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_t,url_s,url_q, url_m,url_n,url_z,url_c,url_l,url_o"
        
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data, let photosResponse = try? JSONDecoder().decode(PhotosResponse.self, from: safeData){
                    self.photosResponse = photosResponse
                    }
            
                
                }
                    
                
            
            task.resume()
        }
    }
    
    private func searchPhotos(with text: String){
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=4db403543040033253f3652e32ddb5d4&text=\(text)&format=json&nojsoncallback=1&extras=description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_t,url_s,url_q, url_m,url_n,url_z,url_c,url_l,url_o"
        
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let json = try? JSONSerialization.jsonObject(with: safeData)
                    print(json)
                    }
            
                
                }
                    
                
            
            task.resume()
        }
    }
    
    private func searchingSetup(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosResponse?.photos?.photo?.count ?? .zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = photosResponse?.photos?.photo?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        cell.ownerImageView.backgroundColor = .darkGray
        cell.ownerNameLabel.text = photo?.ownername
        cell.photoImageView.backgroundColor = .gray
        cell.titleLabel.text = photo?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let destinationVC = segue.destination as! PhotoDetailViewController
            
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
            searchPhotos(with: text)
    }


}
