// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

// 794743
// 775153

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // 2451 gas constant
    // 351 gas non-constant

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    // 444 gas immutable
    // 2558 gas non-immutable

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable  {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough!"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value ;
    }  

    function withdraw() public onlyOwner {
        // without the modifire:
        // require(msg.sender == owner, "Sender is not Owner");

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner {
        require(msg.sender == i_owner, "Sender is not Owner");
        _;
    }
}