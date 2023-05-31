pragma solidity ^0.8.0;

contract MarketFitCalculator {
    struct Startup {
        uint256 productQuality; // Product quality score (out of 10)
        uint256 marketSize; // Market size score (out of 10)
        uint256 competition; // Competition score (out of 10)
    }

    mapping(address => Startup) public startups;

    function setStartupData(address startupAddress, uint256 productQuality, uint256 marketSize, uint256 competition) external {
        Startup storage startup = startups[startupAddress];
        startup.productQuality = productQuality;
        startup.marketSize = marketSize;
        startup.competition = competition;
    }

    function calculateMarketFit(address startupAddress) external view returns (uint256) {
        Startup storage startup = startups[startupAddress];

        // Define weights for each criterion (out of 100)
        uint256 productQualityWeight = 40;
        uint256 marketSizeWeight = 30;
        uint256 competitionWeight = 30;

        // Calculate market fit score as a weighted average
        uint256 marketFitScore = (startup.productQuality * productQualityWeight +
                                  startup.marketSize * marketSizeWeight +
                                  startup.competition * competitionWeight) / 100;

        return marketFitScore;
    }
}

