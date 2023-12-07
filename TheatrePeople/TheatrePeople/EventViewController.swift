import UIKit
import NetworkKit
//import SnapKit

final class EventViewController: UIViewController {
    
    private let funnyImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "masha")
        return image
    }()
    
    private let networkService: NetworkProtocol = NetworkManager()

    init() {
        print("inited")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        setupFunnyImage()
        
        networkService.getCrypto(pair: "btc") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
            case .failure(_):
                print("error")
            }
        }
    }


}

// MARK: - Private func

private extension EventViewController {
    
    func setupView() {
        title = "Спектакли"
        view.backgroundColor = .systemBackground
    }
    
    func setupFunnyImage() {
        view.addSubview(funnyImage)
        
//        funnyImage.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
}
