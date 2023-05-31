pragma solidity ^0.8.0;

contract AdvisoryBoard {
    struct Advisor {
        address advisorAddress;
        string name;
        string expertise;
    }

    mapping(address => Advisor) private advisors;
    address[] private advisorAddresses;

    event AdvisorAdded(address indexed advisorAddress, string name, string expertise);
    event AdvisorRemoved(address indexed advisorAddress);

    function addAdvisor(address advisorAddress, string memory name, string memory expertise) external {
        require(advisors[advisorAddress].advisorAddress == address(0), "Advisor already exists");

        Advisor memory newAdvisor = Advisor({
            advisorAddress: advisorAddress,
            name: name,
            expertise: expertise
        });

        advisors[advisorAddress] = newAdvisor;
        advisorAddresses.push(advisorAddress);

        emit AdvisorAdded(advisorAddress, name, expertise);
    }

    function removeAdvisor(address advisorAddress) external {
        require(advisors[advisorAddress].advisorAddress != address(0), "Advisor does not exist");

        delete advisors[advisorAddress];

        for (uint256 i = 0; i < advisorAddresses.length; i++) {
            if (advisorAddresses[i] == advisorAddress) {
                advisorAddresses[i] = advisorAddresses[advisorAddresses.length - 1];
                advisorAddresses.pop();
                break;
            }
        }

        emit AdvisorRemoved(advisorAddress);
    }

    function getAdvisor(address advisorAddress) external view returns (string memory name, string memory expertise) {
        Advisor storage advisor = advisors[advisorAddress];
        require(advisor.advisorAddress != address(0), "Advisor does not exist");
        return (advisor.name, advisor.expertise);
    }

    function getAllAdvisors() external view returns (address[] memory) {
        return advisorAddresses;
    }
}

