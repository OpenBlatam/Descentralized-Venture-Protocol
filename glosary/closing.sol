pragma solidity ^0.8.0;

contract Closing {
    address public company;
    address public investor;
    uint256 public totalInvestment;
    bool public isClosed;

    event ClosingSet(address indexed company, address indexed investor, uint256 totalInvestment);
    event ClosingCompleted(address indexed company, address indexed investor, uint256 totalInvestment);

    constructor(address _company, address _investor, uint256 _totalInvestment) {
        company = _company;
        investor = _investor;
        totalInvestment = _totalInvestment;
        isClosed = false;
        emit ClosingSet(company, investor, totalInvestment);
    }

    modifier onlyCompany() {
        require(msg.sender == company, "Only the company can perform this action");
        _;
    }

    modifier onlyInvestor() {
        require(msg.sender == investor, "Only the investor can perform this action");
        _;
    }

    modifier notClosed() {
        require(!isClosed, "Closing is already completed");
        _;
    }

    function completeClosing() external onlyCompany notClosed {
        isClosed = true;
        emit ClosingCompleted(company, investor, totalInvestment);
    }

    function updateTotalInvestment(uint256 newTotalInvestment) external onlyCompany notClosed {
        require(newTotalInvestment > 0, "Total investment must be greater than zero");
        totalInvestment = newTotalInvestment;
        emit ClosingSet(company, investor, totalInvestment);
    }

    function withdrawFunds() external onlyInvestor notClosed {
        isClosed = true;
        payable(investor).transfer(address(this).balance);
        emit ClosingCompleted(company, investor, totalInvestment);
    }
}

