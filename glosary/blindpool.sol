pragma solidity ^0.8.0;

contract BlindPool {
    struct Investment {
        address investor;
        uint256 amount;
    }

    address public manager;
    Investment[] private investments;

    event InvestmentMade(address indexed investor, uint256 amount);

    constructor() {
        manager = msg.sender;
    }

    modifier onlyManager() {
        require(msg.sender == manager, "Only the manager can perform this action");
        _;
    }

    function invest() external payable {
        require(msg.value > 0, "Investment amount must be greater than zero");

        investments.push(Investment({
            investor: msg.sender,
            amount: msg.value
        }));

        emit InvestmentMade(msg.sender, msg.value);
    }

    function withdrawFunds() external onlyManager {
        payable(manager).transfer(address(this).balance);
    }
}

