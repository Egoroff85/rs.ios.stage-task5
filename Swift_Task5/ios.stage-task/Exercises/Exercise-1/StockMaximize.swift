import Foundation

class StockMaximize {
    var shares = 0
    var spent = 0
    var profit = 0
    
    func countProfit(prices: [Int]) -> Int {
        if prices.count < 2 {
            return 0
        }
        
        var next: Array<Int>
        var maxPrice = prices.max()
        
        for (i, price) in prices.enumerated() {
            if price == maxPrice {
                self.profit += (self.shares * price) - self.spent
                self.shares = 0
                self.spent = 0
                if i + 1 < prices.count - 1 {
                    next = Array(prices[i + 1...prices.count - 1])
                } else {
                    break
                }
                maxPrice = next.max()
                continue
            }
            self.shares += 1
            self.spent += price
        }
        return self.profit
    }
}
