pragma solidity ^0.8.0;

contract ValuationCalculator {
    struct Company {
        uint256 earnings;
    }

    mapping(address => Company) public companies;

    function setCompanyEarnings(address companyAddress, uint256 earnings) external {
        Company storage company = companies[companyAddress];
        company.earnings = earnings;
    }

    function calculateEarningsValuation(address companyAddress, uint256 earningsMultiple) external view returns (uint256) {
        Company storage company = companies[companyAddress];

        // Calculate the valuation based on the earnings multiple
        uint256 valuation = company.earnings * earningsMultiple;

        return valuation;
    }
}

