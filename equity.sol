pragma solidity 0.8.7;

contract VentureCapital {
    struct Investor {
        uint256 shares;
        uint256 investedAmount;
    }

    mapping(address => Investor) public investors;
    uint256 public totalShares;

    function invest() external payable {
        require(msg.value > 0, "Investment amount must be greater than zero.");

        Investor storage investor = investors[msg.sender];
        investor.shares += msg.value;
        investor.investedAmount += msg.value;
        totalShares += msg.value;
    }

    function calculateEquity(address investorAddress) external view returns (uint256) {
        Investor memory investor = investors[investorAddress];
        return (investor.shares * 100) / totalShares;
    }
}

