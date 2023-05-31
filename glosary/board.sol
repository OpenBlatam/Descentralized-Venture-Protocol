pragma solidity ^0.8.0;

contract VentureBonds {
    struct Bond {
        address issuer;
        uint256 principal;
        uint256 interestRate;
        uint256 maturityDate;
        bool isRedeemed;
    }

    mapping(address => Bond[]) private bonds;

    event BondIssued(address indexed issuer, uint256 principal, uint256 interestRate, uint256 maturityDate);
    event BondRedeemed(address indexed issuer, uint256 principal, uint256 interest);

    modifier onlyIssuer(uint256 bondIndex) {
        require(msg.sender == bonds[msg.sender][bondIndex].issuer, "Only the bond issuer can perform this action");
        _;
    }

    function issueBond(uint256 principal, uint256 interestRate, uint256 maturityDate) external {
        require(principal > 0, "Principal amount must be greater than zero");
        require(interestRate > 0, "Interest rate must be greater than zero");
        require(maturityDate > block.timestamp, "Maturity date must be in the future");

        bonds[msg.sender].push(Bond({
            issuer: msg.sender,
            principal: principal,
            interestRate: interestRate,
            maturityDate: maturityDate,
            isRedeemed: false
        }));

        emit BondIssued(msg.sender, principal, interestRate, maturityDate);
    }

    function redeemBond(uint256 bondIndex) external onlyIssuer(bondIndex) {
        require(!bonds[msg.sender][bondIndex].isRedeemed, "Bond has already been redeemed");

        Bond storage bond = bonds[msg.sender][bondIndex];
        uint256 interest = calculateInterest(bond.principal, bond.interestRate, bond.maturityDate);

        bond.isRedeemed = true;

        payable(msg.sender).transfer(bond.principal + interest);

        emit BondRedeemed(msg.sender, bond.principal, interest);
    }

    function calculateInterest(uint256 principal, uint256 interestRate, uint256 maturityDate) private view returns (uint256) {
        uint256 timeToMaturity = maturityDate - block.timestamp;
        uint256 interest = (principal * interestRate * timeToMaturity) / 365 days;

        return interest;
    }

    function getBonds(address issuer) external view returns (Bond[] memory) {
        return bonds[issuer];
    }
}

