pragma solidity ^0.8.0;

contract CommittedCapital {
    address public investor;
    uint256 public committedAmount;
    bool public isCommitted;

    event CommittedCapitalSet(address indexed investor, uint256 committedAmount);
    event CommittedCapitalReleased(address indexed investor, uint256 committedAmount);

    constructor(address _investor) {
        investor = _investor;
        committedAmount = 0;
        isCommitted = false;
    }

    modifier onlyInvestor() {
        require(msg.sender == investor, "Only the investor can perform this action");
        _;
    }

    modifier notCommitted() {
        require(!isCommitted, "Committed capital is already set");
        _;
    }

    function setCommittedCapital(uint256 amount) external onlyInvestor notCommitted {
        require(amount > 0, "Committed capital amount must be greater than zero");
        committedAmount = amount;
        isCommitted = true;
        emit CommittedCapitalSet(investor, committedAmount);
    }

    function releaseCommittedCapital() external onlyInvestor {
        require(isCommitted, "No committed capital is set");
        isCommitted = false;
        emit CommittedCapitalReleased(investor, committedAmount);
        committedAmount = 0;
    }
}

