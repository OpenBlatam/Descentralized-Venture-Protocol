pragma solidity ^0.8.0;

contract AntiDilution {
    struct Investor {
        address investorAddress;
        uint256 shares;
        uint256 originalInvestment;
    }

    mapping(address => Investor) private investors;

    event SharesAdjusted(address indexed investorAddress, uint256 newShares);

    constructor() {
        // Add initial investors with their shares and original investments
        addInvestor(msg.sender, 100, 1000);
    }

    function addInvestor(address investorAddress, uint256 shares, uint256 originalInvestment) internal {
        require(investors[investorAddress].investorAddress == address(0), "Investor already exists");

        Investor memory newInvestor = Investor({
            investorAddress: investorAddress,
            shares: shares,
            originalInvestment: originalInvestment
        });

        investors[investorAddress] = newInvestor;
    }

    function adjustShares(address investorAddress, uint256 newShares) external {
        require(investors[investorAddress].investorAddress != address(0), "Investor does not exist");

        investors[investorAddress].shares = newShares;

        emit SharesAdjusted(investorAddress, newShares);
    }

    function calculateAdjustedShares(address investorAddress, uint256 newInvestment) external view returns (uint256) {
        require(investors[investorAddress].investorAddress != address(0), "Investor does not exist");

        Investor storage investor = investors[investorAddress];
        uint256 originalInvestment = investor.originalInvestment;
        uint256 originalShares = investor.shares;

        if (newInvestment < originalInvestment) {
            // Calculate adjustment based on the ratchet mechanism
            uint256 adjustmentRatio = (newInvestment * originalShares) / originalInvestment;
            return adjustmentRatio;
        } else {
            // No adjustment needed if new investment is higher or equal to original investment
            return originalShares;
        }
    }

    function getInvestor(address investorAddress) external view returns (uint256 shares, uint256 originalInvestment) {
        Investor storage investor = investors[investorAddress];
        require(investor.investorAddress != address(0), "Investor does not exist");
        return (investor.shares, investor.originalInvestment);
    }
}

