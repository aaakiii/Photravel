import UIKit
import Alamofire
import SwiftyJSON

class PhotoGalleryViewController: UIViewController,
UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var photos = [Photo]()
    var selectedPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName:"PhotoGalleryCollectionViewCell", bundle:nil)
        collectionView.register(nib, forCellWithReuseIdentifier:"Cell")
        getImages()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoGalleryCollectionViewCell
        photoCell.setImage(photo:photos[indexPath.row])
        return photoCell
    }
    
   
    // When cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhoto = Photo(id: photos[indexPath.row].id, imageByUrl:
            photos[indexPath.row].imageByUrl, takenDate: photos[indexPath.row].takenDate)

        selectedPhoto = photos[indexPath.row]
    }
    
    
    func getImages(){
        Flickr.getImage{ (photos) in
            var imageData = [Photo]()
            imageData = Flickr.photos
            self.photos = imageData
            self.collectionView.reloadData()
        }
        
    }
}
