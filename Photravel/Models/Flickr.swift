import UIKit
import Alamofire
import SwiftyJSON


class Flickr{
    
    static func getImage(){
        
        let baseUrl = "https://api.flickr.com/services/rest/"
        let apiKey = Constants.flickrApiKey
        let serchMethod = "flickr.photos.search"
        let formatType = "json"
        let jsonCallback = 1
        let privercyFilter = 1
        let extras = "url_s,date_taken"        
        let query = ["method": serchMethod, "api_key": apiKey, "tags":"tokyo","privacy_filter":privercyFilter, "format":formatType, "nojsoncallback": jsonCallback, "extras":extras] as [String : Any]

    
        // Call JSON Data
        Alamofire.request(baseUrl, parameters: query).responseJSON{ response in
            print(response.result.value!)
        }
    }
}
