// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "./interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "didn't send enough ETH"
        );

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] +=
            addressToAmountFunded[msg.sender] +
            msg.value;
    }

    function withdraw() public onlyOwner {
        require(msg.sender == i_owner, "Must be owner");
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        //   // transfer
        //   payable(msg.sender).transfer(address(this).balance);
        //   //send
        //   bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //   require(sendSuccess,"Send failed");
        //call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        //  require(msg.sender == i_owner, "Must be owner");
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}