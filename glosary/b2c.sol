pragma solidity ^0.8.0;

contract B2CVentureCapital {
    struct Investment {
        address investor;
        string businessName;
        uint256 investedAmount;
        uint256 equity;
    }

    mapping(address => Investment[]) private investments;

    event InvestmentMade(address indexed investor, string businessName, uint256 investedAmount, uint256 equity);

    function makeInvestment(string memory businessName, uint256 investedAmount, uint256 equity) external payable {
        require(investedAmount > 0, "Investment amount must be greater than zero");
        require(equity > 0 && equity <= 100, "Equity percentage must be between 1 and 100");
        require(msg.value >= investedAmount, "Insufficient funds sent");

        investments[msg.sender].push(Investment({
            investor: msg.sender,
            businessName: businessName,
            investedAmount: investedAmount,
            equity: equity
        }));

        emit InvestmentMade(msg.sender, businessName, investedAmount, equity);

        if (msg.value > investedAmount) {
            // Refund excess funds sent
            payable(msg.sender).transfer(msg.value - investedAmount);
        }
    }

    function getInvestments(address investor) external view returns (Investment[] memory) {
        return investments[investor];
    }
}

