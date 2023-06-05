pragma solidity ^0.8.0;

contract VentureRateStrategy {
    // Mapping to store the venture rates for different ventures
    mapping(address => uint256) public ventureRates;

    // Event to emit when a venture rate is updated
    event VentureRateUpdated(address indexed venture, uint256 rate);

    // Function to update the venture rate for a specific venture
    function updateVentureRate(address venture, uint256 rate) external {
        require(rate > 0, "Rate must be greater than zero");

        ventureRates[venture] = rate;

        emit VentureRateUpdated(venture, rate);
    }

    // Function to calculate the investment amount based on the venture rate
    function calculateInvestmentAmount(address venture, uint256 amount) external view returns (uint256) {
        require(ventureRates[venture] > 0, "Venture rate not set for the venture");

        uint256 ventureRate = ventureRates[venture];

        return amount * ventureRate / 100;
    }
}
