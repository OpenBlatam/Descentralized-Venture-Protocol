pragma solidity ^0.8.0;

contract AngelFinancing {
    struct Investor {
        address investorAddress;
        uint256 investedAmount;
        uint256 equity;
        bool active;
    }

    mapping(address => Investor) private investors;
    address[] private investorAddresses;
    uint256 private totalInvestedAmount;

    event InvestorAdded(address indexed investorAddress, uint256 investedAmount, uint256 equity);
    event InvestorUpdated(address indexed investorAddress, uint256 investedAmount, uint256 equity);
    event InvestorDeactivated(address indexed investorAddress);

    function addInvestor(address investorAddress, uint256 investedAmount, uint256 equity) external {
        require(investors[investorAddress].investorAddress == address(0), "Investor already exists");

        Investor memory newInvestor = Investor({
            investorAddress: investorAddress,
            investedAmount: investedAmount,
            equity: equity,
            active: true
        });

        investors[investorAddress] = newInvestor;
        investorAddresses.push(investorAddress);
        totalInvestedAmount += investedAmount;

        emit InvestorAdded(investorAddress, investedAmount, equity);
    }

    function updateInvestor(address investorAddress, uint256 investedAmount, uint256 equity) external {
        require(investors[investorAddress].investorAddress != address(0), "Investor does not exist");
        require(investors[investorAddress].active, "Investor is deactivated");

        totalInvestedAmount = totalInvestedAmount - investors[investorAddress].investedAmount + investedAmount;
        investors[investorAddress].investedAmount = investedAmount;
        investors[investorAddress].equity = equity;

        emit InvestorUpdated(investorAddress, investedAmount, equity);
    }

    function deactivateInvestor(address investorAddress) external {
        require(investors[investorAddress].investorAddress != address(0), "Investor does not exist");

        investors[investorAddress].active = false;

        emit InvestorDeactivated(investorAddress);
    }

    function getInvestor(address investorAddress) external view returns (uint256 investedAmount, uint256 equity, bool active) {
        Investor storage investor = investors[investorAddress];
        require(investor.investorAddress != address(0), "Investor does not exist");
        return (investor.investedAmount, investor.equity, investor.active);
    }

    function getAllInvestors() external view returns (address[] memory) {
        return investorAddresses;
    }

    function getTotalInvestedAmount() external view returns (uint256) {
        return totalInvestedAmount;
    }
}

