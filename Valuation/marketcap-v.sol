pragma solidity ^0.8.0;

contract MarketCapitalizationValuation {
    uint256 public sharePrice;
    uint256 public numShares;

    constructor(uint256 _sharePrice, uint256 _numShares) {
        sharePrice = _sharePrice;
        numShares = _numShares;
    }

    function calculateValuation() external view returns (uint256) {
        return sharePrice * numShares;
    }
}

