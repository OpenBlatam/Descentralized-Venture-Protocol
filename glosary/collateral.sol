pragma solidity ^0.8.0;

contract Collateral {
    address public borrower;
    uint256 public collateralAmount;
    bool public isCollateralized;

    event CollateralSet(address indexed borrower, uint256 collateralAmount);
    event CollateralReleased(address indexed borrower, uint256 collateralAmount);

    constructor(address _borrower) {
        borrower = _borrower;
        collateralAmount = 0;
        isCollateralized = false;
    }

    modifier onlyBorrower() {
        require(msg.sender == borrower, "Only the borrower can perform this action");
        _;
    }

    modifier notCollateralized() {
        require(!isCollateralized, "Collateral is already set");
        _;
    }

    function setCollateral(uint256 amount) external onlyBorrower notCollateralized {
        require(amount > 0, "Collateral amount must be greater than zero");
        collateralAmount = amount;
        isCollateralized = true;
        emit CollateralSet(borrower, collateralAmount);
    }

    function releaseCollateral() external onlyBorrower {
        require(isCollateralized, "No collateral is set");
        isCollateralized = false;
        emit CollateralReleased(borrower, collateralAmount);
        collateralAmount = 0;
    }
}

