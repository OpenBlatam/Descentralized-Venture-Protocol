pragma solidity ^0.8.0;

contract CoInvestment {
    address public investor1;
    address public investor2;
    uint256 public totalInvestment;
    uint256 public investor1Share;
    uint256 public investor2Share;
    bool public isClosed;

    event CoInvestmentSet(address indexed investor1, address indexed investor2, uint256 totalInvestment);
    event CoInvestmentCompleted(address indexed investor1, address indexed investor2, uint256 totalInvestment);

    constructor(address _investor1, address _investor2, uint256 _totalInvestment) {
        investor1 = _investor1;
        investor2 = _investor2;
        totalInvestment = _totalInvestment;
        investor1Share = 0;
        investor2Share = 0;
        isClosed = false;
        emit CoInvestmentSet(investor1, investor2, totalInvestment);
    }

    modifier onlyInvestor1() {
        require(msg.sender == investor1, "Only investor 1 can perform this action");
        _;
    }

    modifier onlyInvestor2() {
        require(msg.sender == investor2, "Only investor 2 can perform this action");
        _;
    }

    modifier notClosed() {
        require(!isClosed, "Co-investment is already completed");
        _;
    }

    function completeCoInvestment(uint256 investor1ShareAmount, uint256 investor2ShareAmount) external notClosed {
        require(investor1ShareAmount + investor2ShareAmount == totalInvestment, "Shares must add up to total investment");

        investor1Share = investor1ShareAmount;
        investor2Share = investor2ShareAmount;
        isClosed = true;

        emit CoInvestmentCompleted(investor1, investor2, totalInvestment);
    }

    function withdrawFunds() external notClosed {
        require(investor1Share > 0 && investor2Share > 0, "Shares must be set before withdrawing funds");

        isClosed = true;

        payable(investor1).transfer(investor1Share);
        payable(investor2).transfer(investor2Share);

        emit CoInvestmentCompleted(investor1, investor2, totalInvestment);
    }
}

