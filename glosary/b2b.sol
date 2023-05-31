pragma solidity ^0.8.0;

contract B2BVentureCapital {
    struct Investment {
        address investor;
        address business;
        uint256 investedAmount;
        uint256 equity;
        bool isFunded;
    }

    mapping(address => Investment[]) private investments;

    event InvestmentMade(address indexed investor, address indexed business, uint256 investedAmount, uint256 equity);
    event FundingReceived(address indexed business, uint256 amount);

    function makeInvestment(address business, uint256 investedAmount, uint256 equity) external {
        require(investedAmount > 0, "Investment amount must be greater than zero");
        require(equity > 0 && equity <= 100, "Equity percentage must be between 1 and 100");

        investments[business].push(Investment({
            investor: msg.sender,
            business: business,
            investedAmount: investedAmount,
            equity: equity,
            isFunded: false
        }));

        emit InvestmentMade(msg.sender, business, investedAmount, equity);
    }

    function receiveFunding() external payable {
        require(msg.value > 0, "Funding amount must be greater than zero");

        address business = msg.sender;
        Investment[] storage businessInvestments = investments[business];

        require(businessInvestments.length > 0, "No investments made by this business");

        uint256 totalInvestment = 0;
        uint256 remainingEquity = 100;

        for (uint256 i = 0; i < businessInvestments.length; i++) {
            Investment storage investment = businessInvestments[i];

            if (!investment.isFunded) {
                uint256 investorShare = (investment.equity * msg.value) / 100;
                investment.isFunded = true;

                // Transfer investor's share of funding
                payable(investment.investor).transfer(investorShare);

                totalInvestment += investorShare;
                remainingEquity -= investment.equity;
            }
        }

        // Transfer remaining funding amount to the business
        payable(business).transfer(msg.value - totalInvestment);

        emit FundingReceived(business, msg.value);
    }

    function getInvestments(address business) external view returns (Investment[] memory) {
        return investments[business];
    }
}

