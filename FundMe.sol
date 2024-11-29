
// Get funds from users
// Withdraw funds
// set a miminum funding value in USD
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "./interfaces/AggregatorV3Interface.sol"; // import 


contract FundMe {
   address adrss = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
   uint256 public minimumUsd = 5e18;


   address[] public funders;
   mapping(address funder=>uint256 amountFunded) public addressToAmountFunded;

   
   function fund() public payable  {
       // 1. How do we send ETH to this contract?
       require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
       funders.push(msg.sender);
       addressToAmountFunded[msg.sender] += addressToAmountFunded[msg.sender]+msg.value;
       // what is a revert?
       // undo any actions that have been done, and send remaining gas back

   }


   function getPrice() public view returns(uint256) {
      
      // price 0x694AA1769357215DE4FAC081bf1f309aDC325306
      // ABI interface

      AggregatorV3Interface priceFeed = AggregatorV3Interface(adrss);
      (,int256 price,,,) = priceFeed.latestRoundData();
      // price opf Eth in terms usd
      // 200000000
      return uint256(price *1e10);
 
   }
   function getConversionRate(uint256 ethAmount) public view returns(uint256){
      // 1 eth
      // 2000^18
      // 
      uint256 ethPrice = getPrice();
      // 2000^18 * 1^18 /1e18
      // 2000 = 1eth
      uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
      return ethAmountInUsd;
   }

   function getVersion() public view returns(uint256){
      return AggregatorV3Interface(adrss).version();

   }

//    function withdraw() public {}
 
}
