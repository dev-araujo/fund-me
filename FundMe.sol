
// Get funds from users
// Withdraw funds
// set a miminum funding value in USD
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "./interfaces/AggregatorV3Interface.sol"; // import 


contract FundMe {
   address adrss = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
   uint256 public minimumUsd = 5;

   
   function fund() public payable  {
       // 1. How do we send ETH to this contract?
       require(msg.value >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18

       // what is a revert?
       // undo any actions that have been done, and send remaining gas back

   }


   function getPrice() public {
      
      // price 0x694AA1769357215DE4FAC081bf1f309aDC325306
      // ABI interface
 
   }
   function getConversionRate() public{

   }

   function getVersion() public view returns(uint256){
      return AggregatorV3Interface(adrss).version();

   }

//    function withdraw() public {}
 
}
