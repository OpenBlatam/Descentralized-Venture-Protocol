pragma solidity ^0.8.0;

contract VentureCapitalAmortization {
    struct AmortizationEntry {
        uint256 installmentNumber;
        uint256 principalAmount;
        uint256 interestAmount;
        uint256 totalAmount;
        uint256 remainingAmount;
    }

    AmortizationEntry[] public amortizationSchedule;

    function calculateAmortizationSchedule(uint256 loanAmount, uint256 interestRate, uint256 installmentCount) external {
        require(installmentCount > 0, "Invalid installment count");

        uint256 remainingAmount = loanAmount;
        uint256 interest;
        uint256 principal;
        uint256 totalAmount;

        for (uint256 i = 1; i <= installmentCount; i++) {
            interest = (remainingAmount * interestRate) / 100;
            principal = loanAmount / installmentCount;
            totalAmount = principal + interest;
            remainingAmount -= principal;

            amortizationSchedule.push(AmortizationEntry({
                installmentNumber: i,
                principalAmount: principal,
                interestAmount: interest,
                totalAmount: totalAmount,
                remainingAmount: remainingAmount
            }));
        }
    }

    function getAmortizationEntry(uint256 installmentNumber) external view returns (
        uint256 principalAmount,
        uint256 interestAmount,
        uint256 totalAmount,
        uint256 remainingAmount
    ) {
        require(installmentNumber > 0 && installmentNumber <= amortizationSchedule.length, "Invalid installment number");

        AmortizationEntry storage entry = amortizationSchedule[installmentNumber - 1];
        return (
            entry.principalAmount,
            entry.interestAmount,
            entry.totalAmount,
            entry.remainingAmount
        );
    }

    function getAmortizationScheduleLength() external view returns (uint256) {
        return amortizationSchedule.length;
    }
}

