pragma solidity ^0.8.0;

contract MarketFitCalculator {
    struct Startup {
        uint256 targetMarketSize;
        uint256 marketShare;
        uint256 competitionIntensity;
        uint256 productDifferentiation;
    }

    mapping(address => Startup) public startups;

    function setStartupData(
        address startupAddress,
        uint256 targetMarketSize,
        uint256 marketShare,
        uint256 competitionIntensity,
        uint256 productDifferentiation
    ) external {
        Startup storage startup = startups[startupAddress];
        startup.targetMarketSize = targetMarketSize;
        startup.marketShare = marketShare;
        startup.competitionIntensity = competitionIntensity;
        startup.productDifferentiation = productDifferentiation;
    }

    function calculateMarketFit(address startupAddress) external view returns (uint256) {
        Startup storage startup = startups[startupAddress];

        // Calculate the market fit score based on various factors
        uint256 marketFit = (startup.marketShare * startup.productDifferentiation) / (startup.targetMarketSize * startup.competitionIntensity);

        return marketFit;
    }
}

