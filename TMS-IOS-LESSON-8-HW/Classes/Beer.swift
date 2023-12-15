import Foundation

struct Beer {
    let id: Int
    let name: String
    let price: Double
    let country: String
    var volume: Int // Остаток объема

    init(id: Int, name: String, price: Double, country: String, volume: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.country = country
        self.volume = volume
    }
    
    mutating func sell(soldValume: Int, completion: (_ newVolume: Int) -> ()) {
        
        let result = self.volume - soldValume
  
        if result >= 0 {
            self.volume = result
            completion(self.volume)
        } else {
            print("Sorry! This type of Beer is ended up...")
        }
    }
}
