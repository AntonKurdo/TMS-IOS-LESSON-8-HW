import Foundation

class BeerManager {
    
    private let defaultBeerList = [Beer(id: 1, name: "Pale Ale", price: 1.5, country: "Belgium", volume: 10), Beer(id: 2,name: "Wheat Ale", price: 1, country: "Germany", volume: 20), Beer(id: 3, name: "Irish Ale", price: 1, country: "Germany", volume: 25), Beer(id: 4,name: "Pink Ale", price: 2, country: "Canada", volume: 15)]
    static let shared = BeerManager()
    private var revenue: Double = 0
    var beerList: [Beer]
    
    private init() {
        self.beerList = defaultBeerList
    }
    
    func getRevenue() -> Double {
        return self.revenue
    }
    
    func sellBeer(beer: Beer, volume: Int, completion: (_ newVolume: Int, _ newRevenue: Double) -> ()) {
        revenue += beer.price
        self.beerList =  self.beerList.map { b in
            if(b.name == beer.name) {
                var copy = b;
                copy.sell(soldValume: volume) { newVol in
                    completion(newVol, self.revenue)
                }
                return copy
            }
            return b
        }
    }
    
    func reset() {
        self.beerList = defaultBeerList
        self.revenue = 0
    }
}
