pragma solidity ^0.8.0;

contract BookValueValuation {
    uint256 public totalAssets;
    uint256 public totalLiabilities;

    constructor(uint256 _totalAssets, uint256 _totalLiabilities) {
        totalAssets = _totalAssets;
        totalLiabilities = _totalLiabilities;
    }

    function calculateValuation() external view returns (uint256) {
        return totalAssets - totalLiabilities;
    }
}

