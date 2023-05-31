pragma solidity ^0.8.0;

library MarketFitFramework {
    struct MarketFitMetrics {
        uint256 targetMarketSize;
        uint256 totalAddressableMarketSize;
        uint256 customerAcquisitionCost;
        uint256 customerRetentionRate;
    }

    function calculateMarketFitScore(MarketFitMetrics memory metrics) internal pure returns (uint256) {
        uint256 marketFitScore = 0;

        // Calculate market potential as a percentage of the total addressable market
        if (metrics.targetMarketSize > 0 && metrics.totalAddressableMarketSize > 0) {
            marketFitScore += (metrics.targetMarketSize * 100) / metrics.totalAddressableMarketSize;
        }

        // Calculate customer retention rate relative to customer acquisition cost
        if (metrics.customerAcquisitionCost > 0 && metrics.customerRetentionRate > 0) {
            marketFitScore += (metrics.customerRetentionRate * 100) / metrics.customerAcquisitionCost;
        }

        return marketFitScore;
    }
}

