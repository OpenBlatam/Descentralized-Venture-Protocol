pragma solidity ^0.8.0;

contract VentureCapitalMethodValuation {
    uint256 public futureExitValue;
    uint256 public desiredReturn;
    uint256 public ownershipPercentage;

    constructor(uint256 _futureExitValue, uint256 _desiredReturn, uint256 _ownershipPercentage) {
        futureExitValue = _futureExitValue;
        desiredReturn = _desiredReturn;
        ownershipPercentage = _ownershipPercentage;
    }

    function calculateValuation() external view returns (uint256) {
        uint256 preMoneyValuation = (futureExitValue * 100) / (desiredReturn - ownershipPercentage);
        return preMoneyValuation - futureExitValue;
    }
}

