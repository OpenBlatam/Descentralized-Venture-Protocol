pragma solidity ^0.8.0;

contract ValuationCalculator {
    function calculateDCFValuation(uint256 projectedCashFlows, uint256 discountRate) external pure returns (uint256) {
        require(discountRate > 0, "Discount rate must be greater than zero");

        // Calculate the present value of projected cash flows using the DCF formula
        uint256 valuation = projectedCashFlows / (1 + discountRate);

        return valuation;
    }
}

