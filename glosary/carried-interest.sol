pragma solidity ^0.8.0;

contract CarriedInterest {
    address public generalPartner;
    address public limitedPartner;
    uint256 public carriedInterestPercentage;
    uint256 public totalInvestment;
    uint256 public carriedInterestBalance;

    event CarriedInterestSet(address indexed generalPartner, address indexed limitedPartner, uint256 percentage);
    event CarriedInterestReleased(address indexed receiver, uint256 amount);

    constructor(
        address _generalPartner,
        address _limitedPartner,
        uint256 _carriedInterestPercentage
    ) {
        generalPartner = _generalPartner;
        limitedPartner = _limitedPartner;
        carriedInterestPercentage = _carriedInterestPercentage;
        emit CarriedInterestSet(generalPartner, limitedPartner, carriedInterestPercentage);
    }

    modifier onlyGeneralPartner() {
        require(msg.sender == generalPartner, "Only the general partner can perform this action");
        _;
    }

    function releaseCarriedInterest() external onlyGeneralPartner {
        require(carriedInterestBalance > 0, "No carried interest available to release");

        uint256 amount = (carriedInterestBalance * carriedInterestPercentage) / 100;
        carriedInterestBalance -= amount;
        payable(limitedPartner).transfer(amount);
        emit CarriedInterestReleased(limitedPartner, amount);
    }

    function setCarriedInterest(uint256 percentage) external onlyGeneralPartner {
        require(percentage > 0, "Percentage must be greater than zero");
        carriedInterestPercentage = percentage;
        emit CarriedInterestSet(generalPartner, limitedPartner, carriedInterestPercentage);
    }

    function addToCarriedInterestBalance(uint256 amount) external onlyGeneralPartner {
        require(amount > 0, "Amount must be greater than zero");
        carriedInterestBalance += amount;
    }

    function addToTotalInvestment(uint256 amount) external onlyGeneralPartner {
        require(amount > 0, "Amount must be greater than zero");
        totalInvestment += amount;
    }

    function getCarriedInterestBalance() external view returns (uint256) {
        return carriedInterestBalance;
    }

    function getTotalInvestment() external view returns (uint256) {
        return totalInvestment;
    }
}

