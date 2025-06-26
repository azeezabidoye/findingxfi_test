// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract FundingXFI {
    address public owner;
    uint256 public minimumAmount = 20 * 1e18; // ETH to Wei
    mapping(address => uint256) public addressToAmountFunded;
    mapping(address => bool) private hasFunded;
    address[] private funders;

    constructor() {
        owner = msg.sender;
    }

    function fund() external payable {
        require(msg.value > minimumAmount, "Send enough funds!");

        if (!hasFunded[msg.sender]) {
            hasFunded[msg.sender] = true;
            funders.push(msg.sender);
        }

        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() external onlyOwner {
        for (uint256 i = 0; i < funders.length; ) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
            hasFunded[funder] = false;
            unchecked {
                ++i;
            } // Save gas by skipping overflow check
        }

        delete funders;

        (bool success, ) = payable(owner).call{value: address(this).balance}(
            ""
        );
        require(success, "Withdraw failed!");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner!");
        _;
    }

    function getFunders() external view returns (address[] memory) {
        return funders;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract FundXFI {
    address public immutable i_owner;
    uint256 public constant MINIMUM_AMOUNT = 20 * 1e18; // ETH to Wei
    mapping(address => uint256) public addressToAmountFunded;
    mapping(address => bool) private hasFunded;
    address[] private funders;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() external payable {
        require(msg.value > MINIMUM_AMOUNT, "Send some ETH");

        if (!hasFunded[msg.sender]) {
            hasFunded[msg.sender] = true;
            funders.push(msg.sender);
        }

        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() external onlyOwner {
        uint256 len = funders.length;

        for (uint256 i = 0; i < len; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
            hasFunded[funder] = false;
            unchecked {
                ++i;
            } // Save gas by skipping overflow check
        }

        delete funders;

        (bool success, ) = payable(i_owner).call{value: address(this).balance}(
            ""
        );
        require(success, "Withdraw failed");
    }

    modifier onlyOwner() {
        require(msg.sender == i_owner, "Not owner");
        _;
    }

    function getFunders() external view returns (address[] memory) {
        return funders;
    }
}
