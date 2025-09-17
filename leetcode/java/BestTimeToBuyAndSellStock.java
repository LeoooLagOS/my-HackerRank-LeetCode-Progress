class Solution {
    public int maxProfit(int[] prices) {
        // Initialize minPrice to the largest possible value.
        int minPrice = Integer.MAX_VALUE;
        int maxProfit = 0;

        // Use an enhanced for-loop to iterate through each price.
        for (int price : prices) {
            // If we find a new, lower price, it's a better time to buy.
            if (price < minPrice) {
                minPrice = price;
            } 
            // Otherwise, check if selling at the current price gives a better profit.
            else if (price - minPrice > maxProfit) {
                maxProfit = price - minPrice;
            }
        }
        
        return maxProfit;
    }
}
