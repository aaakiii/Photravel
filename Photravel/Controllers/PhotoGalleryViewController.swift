import UIKit

class PhotoGalleryViewController: UIViewController,
UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let testXib = UINib(nibName:"PhotoGalleryCollectionViewCell", bundle:nil)
        collectionView.register(testXib, forCellWithReuseIdentifier:"Cell")

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoGalleryCollectionViewCell
//        cell?.setImage(photo:photos[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
