// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

library DataTypes {
    struct Investor {
        uint256 totalShares;
        uint256 investedAmount;
        mapping(uint256 => FundingRound) fundingRounds;
        uint256[] vestingPeriods;
    }

    struct FundingRound {
        uint256 shares;
        uint256 pricePerShare;
    }

    struct VentureCapital {
        mapping(address => Investor) investors;
        uint256 totalShares;
    }

    struct VentureRateStrategy {
        mapping(address => uint256) ventureRates;
    }

    struct VentureCapitalFacilitator {
        mapping(address => Investor) investors;
        uint256 totalShares;
        uint256 totalContributedAmount;
    }

    // Add any other venture capital-related data structures or fields here

    // Add any other venture capital-related functions here
}
