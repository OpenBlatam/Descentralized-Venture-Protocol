Libraries and Interfaces:

SafeMath: A library for performing safe mathematical operations.
IERC20: An interface for interacting with ERC20 tokens.
IBalanceVenture: An interface for scales venture capital.
IScaledBalanceToken: An interface for scaled balance tokens.
ReserveLogic: A library for working with reserve data and configurations.
ReserveConfiguration: A library for working with reserve configurations.
UserConfiguration: A library for working with user configurations.
WadRayMath: A library for decimal calculations using fixed-point math.
PercentageMath: A library for calculating percentages using fixed-point math.
IPriceOracleGetter: An interface for fetching asset prices from an oracle.
DataTypes: A contract defining various data types used within the code.
Constants:

HEALTH_FACTOR_LIQUIDATION_THRESHOLD: A constant representing the minimum health factor required to avoid liquidation.
Structs:

CalculateUserAccountDataVars: A struct used to store variables during the calculation of user account data.
Functions:

calculateUserAccountData: Calculates the user data across the reserves, including total collateral, total debt, average LTV, average liquidation threshold, and health factor.
calculateHealthFactorFromBalances: Calculates the health factor based on collateral, debt, and liquidation threshold.
calculateAvailableBorrows: Calculates the maximum amount that can be borrowed based on available collateral, total debt, and average LTV.
getUserAccountData: A proxy function that provides a simplified external interface to call calculateUserAccountData.
