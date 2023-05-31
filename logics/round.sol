pragma solidity 0.8.7;

contract VentureCapital {
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

    mapping(address => Investor) public investors;
    uint256 public totalShares;

    function invest(uint256 fundingRoundId, uint256 shares) external payable {
        require(shares > 0, "Shares must be greater than zero.");

        Investor storage investor = investors[msg.sender];
        FundingRound storage fundingRound = investor.fundingRounds[fundingRoundId];
        require(fundingRound.shares == 0, "Investor has already participated in this funding round.");

        fundingRound.shares = shares;
        fundingRound.pricePerShare = msg.value / shares;

        investor.totalShares += shares;
        investor.investedAmount += msg.value;
        totalShares += shares;
    }

    function calculateEquity(address investorAddress) external view returns (uint256) {
        Investor memory investor = investors[investorAddress];
        return (investor.totalShares * 100) / totalShares;
    }

    function calculateVestedShares(address investorAddress, uint256 fundingRoundId, uint256 timestamp) external view returns (uint256) {
        Investor memory investor = investors[investorAddress];
        FundingRound memory fundingRound = investor.fundingRounds[fundingRoundId];
        require(fundingRound.shares > 0, "Investor has not participated in this funding round.");

        uint256 vestedShares;

        for (uint256 i = 0; i < investor.vestingPeriods.length; i++) {
            if (investor.vestingPeriods[i] <= timestamp) {
                vestedShares += fundingRound.shares;
            } else {
                break;
            }
        }

        return vestedShares;
    }

    function calculateDilutedEquity(address investorAddress, uint256 fundingRoundId, uint256 timestamp) external view returns (uint256) {
        Investor memory investor = investors[investorAddress];
        FundingRound memory fundingRound = investor.fundingRounds[fundingRoundId];
        require(fundingRound.shares > 0, "Investor has not participated in this funding round.");

        uint256 vestedShares = calculateVestedShares(investorAddress, fundingRoundId, timestamp);
        uint256 dilutedShares = vestedShares + fundingRound.shares;

        return (dilutedShares * 100) / totalShares;
    }
}

