pragma solidity ^0.8.0;

contract AngelInvestor {
    struct Investment {
        address investor;
        string companyName;
        uint256 investedAmount;
        uint256 equity;
    }

    Investment[] private investments;

    function invest(string memory companyName, uint256 investedAmount, uint256 equity) external {
        require(investedAmount > 0, "Investment amount must be greater than zero");
        require(equity > 0 && equity <= 100, "Equity percentage must be between 1 and 100");

        investments.push(Investment({
            investor: msg.sender,
            companyName: companyName,
            investedAmount: investedAmount,
            equity: equity
        }));
    }

    function getInvestment(uint256 index) external view returns (
        address investor,
        string memory companyName,
        uint256 investedAmount,
        uint256 equity
    ) {
        require(index < investments.length, "Invalid index");

        Investment storage investment = investments[index];
        return (
            investment.investor,
            investment.companyName,
            investment.investedAmount,
            investment.equity
        );
    }

    function getTotalInvestments() external view returns (uint256) {
        return investments.length;
    }
}

