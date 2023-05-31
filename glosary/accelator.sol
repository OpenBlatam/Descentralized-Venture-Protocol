pragma solidity ^0.8.0;

contract VentureCapitalAccelerator {
    struct Investment {
        address investor;
        uint256 amount;
        uint256 equity;
    }

    Investment[] private investments;
    uint256 private totalInvestedAmount;

    function invest(uint256 equity) external payable {
        require(msg.value > 0, "Investment amount must be greater than zero");

        investments.push(Investment({
            investor: msg.sender,
            amount: msg.value,
            equity: equity
        }));

        totalInvestedAmount += msg.value;
    }

    function getTotalInvestedAmount() external view returns (uint256) {
        return totalInvestedAmount;
    }

    function getInvestorCount() external view returns (uint256) {
        return investments.length;
    }

    function getInvestment(uint256 index) external view returns (address investor, uint256 amount, uint256 equity) {
        require(index < investments.length, "Invalid index");

        Investment storage investment = investments[index];
        return (investment.investor, investment.amount, investment.equity);
    }
}

