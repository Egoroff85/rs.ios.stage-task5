import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func knapSack(supplies: [Supply]) -> [[Int]] {
        let n = supplies.count

        var t = Array(repeating: Array(repeating: 0, count: self.maxWeight + 1), count: n + 1)
        for i in 0..<n + 1 {
            for j in 0..<self.maxWeight + 1 {
                if i == 0 || j == 0 {
                    t[i][j] = 0
                } else if supplies[i - 1].weight <= j {
                    t[i][j] = max(supplies[i - 1].value + t[i - 1][j - supplies[i - 1].weight], t[i - 1][j])
                } else {
                    t[i][j] = t[i - 1][j]
                }
            }
        }        
        return t
    }
    
    func findMaxKilometres() -> Int {
        var maxDistance = 0
        
        if self.maxWeight < 0 {
            return maxDistance
        }

        let foodsMatrix = knapSack(supplies: self.foods)
        let drinksMatrix = knapSack(supplies: self.drinks)
        
        let foodsCount = self.foods.count
        let drinksCount = self.drinks.count
        
        for weight in 0...self.maxWeight {
            let currentMaxDistance = min(foodsMatrix[foodsCount][weight], drinksMatrix[drinksCount][self.maxWeight - weight])
            if currentMaxDistance > maxDistance {
                maxDistance = currentMaxDistance
            }
        }
        return maxDistance
    }
}
