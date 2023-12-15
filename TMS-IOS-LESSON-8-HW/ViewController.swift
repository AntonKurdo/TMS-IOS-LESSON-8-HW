import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let beerManager = BeerManager.shared
    
    let mainContentView = UIConstructor.createView()
    let mainTitle = UIConstructor.createLabel(text: "🍻 Best Beer Bar 🍻", font: UIFont.boldSystemFont(ofSize: 26),  tag: nil)
    let revenueLabel = UIConstructor.createLabel(text: "Total for today: 0 💵", tag: nil)
    let resetButton = UIConstructor.createButton(title: "Reset/Start New Day", tag: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        addInitialSubviews()
        
        resetButton.addAction(UIAction(handler: { _ in
            self.beerManager.reset()
            self.revenueLabel.text = "Total for today: \(self.beerManager.getRevenue()) 💵"
            self.beerManager.beerList.forEach { beer in
                let lab = self.mainContentView.viewWithTag(beer.id) as! UILabel
                lab.text = "🍺 \(beer.name) / \(beer.volume)"
                
                let btn = self.mainContentView.viewWithTag(beer.id * 10) as! UIButton
                btn.isEnabled = true
            }
        }), for: .touchUpInside)
       
        setupMainContent()
        setupConstraints()
    }
    
    private func setupMainContent() {
        beerManager.beerList.enumerated().forEach { (index, element) in
            let beerItemView = UIConstructor.createView()
            
            mainContentView.addSubview(beerItemView)
            
            beerItemView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(40 * (index + 1) + 100 * index)
                make.height.equalTo(100)
                make.width.equalToSuperview()
            }
            
            let label = UIConstructor.createLabel(text: "🍺 \(element.name) / \(element.volume)", tag: element.id)
            
            let button = UIConstructor.createButton(title: "Buy 1 pinta / \(element.price)$", tag: element.id * 10)
            
            button.addAction(UIAction(handler: { _ in
                self.beerManager.sellBeer(beer: element, volume: 1) { updatedVolume, updatedRevenue in
                    label.text = "🍺 \(element.name) / \(updatedVolume)"
                    self.revenueLabel.text = "Total for today: \(updatedRevenue) 💵"

                    if(updatedVolume == 0) {
                        button.isEnabled = false
                    }
                }
            }), for: .touchUpInside)
            
            beerItemView.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-30)
            }
            
            beerItemView.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(30)
            }
        }
    }
    
    private func addInitialSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(revenueLabel)
        view.addSubview(mainContentView)
        view.addSubview(resetButton)
    }
    
    private func setupConstraints() {
        revenueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
    
        mainContentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(600)
            make.width.equalToSuperview()
        }
        
        resetButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
}

