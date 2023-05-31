pragma solidity ^0.8.0;

contract ValuationCap {
    address public company;
    uint256 public cap;

    event CapSet(uint256 newCap);

    constructor(uint256 _cap) {
        company = msg.sender;
        cap = _cap;
        emit CapSet(cap);
    }

    modifier onlyCompany() {
        require(msg.sender == company, "Only the company can perform this action");
        _;
    }

    function setCap(uint256 newCap) external onlyCompany {
        require(newCap > 0, "Cap must be greater than zero");
        cap = newCap;
        emit CapSet(cap);
    }
}

