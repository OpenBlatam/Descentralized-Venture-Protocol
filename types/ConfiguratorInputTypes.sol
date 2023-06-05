// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

library ConfiguratorInputTypes {
    struct InitReserveInput {
        address aTokenImpl;
        address stableDebtTokenImpl;
        address variableDebtTokenImpl;
        uint8 underlyingAssetDecimals;
        address interestRateStrategyAddress;
        address underlyingAsset;
        address treasury;
        address incentivesController;
        string aTokenName;
        string aTokenSymbol;
        string variableDebtTokenName;
        string variableDebtTokenSymbol;
        string stableDebtTokenName;
        string stableDebtTokenSymbol;
        bytes params;
    }

    struct UpdateATokenInput {
        address asset;
        address treasury;
        address incentivesController;
        string name;
        string symbol;
        address implementation;
        bytes params;
    }

    struct UpdateDebtTokenInput {
        address asset;
        address incentivesController;
        string name;
        string symbol;
        address implementation;
        bytes params;
    }

    // Venture Capital specific inputs
    struct CreateInvestorInput {
        address investorAddress;
        uint256 totalShares;
        uint256 investedAmount;
        uint256[] vestingPeriods;
    }

    struct UpdateInvestorSharesInput {
        address investorAddress;
        uint256 totalShares;
    }

    struct AddFundingRoundInput {
        address investorAddress;
        uint256 fundingRoundId;
        uint256 shares;
        uint256 pricePerShare;
    }

    struct UpdateFundingRoundInput {
        address investorAddress;
        uint256 fundingRoundId;
        uint256 shares;
        uint256 pricePerShare;
    }

    struct UpdateVestingPeriodsInput {
        address investorAddress;
        uint256[] vestingPeriods;
    }

    // Add any other venture capital-related input structures here
}
