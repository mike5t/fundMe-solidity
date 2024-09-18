

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// get funds from users
// withdraw funds
//set a minimum value in USD

// solhint-disable-next-line interface-starts-with-i

import {PriceConverter} from "./PriceCoverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;


   uint256 public constant MINIMUM_USD = 5e18;

   address[] public funders;

   mapping(address funder => uint256 amoundFounded) public addressToAmountFounded;
   
    address public immutable i_owner;

       constructor( ) {
          
          i_owner = msg.sender;
       }
   
    function fund() public  payable 
{
    // ALLOW USERS TO SEND $
    // HAVE MINIMUM $ SENT

    msg.value.getConversionRate();
    
    require(msg.value.getConversionRate() >= MINIMUM_USD, " didn't send enough ETH");// 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
    funders.push(msg.sender);
    addressToAmountFounded[msg.sender] += msg.value;
}

    function withdraw() public onlyOwner {
           
           
        //for loop

        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){

            address funder = funders[funderIndex];
            addressToAmountFounded[funder] = 0;
        }

        funders = new address[](0);

       // call
        (bool callsuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callsuccess, "call failed");


       

    }


    modifier onlyOwner() {

      //require(msg.sender == i_owner, "Must be owner");
       if(msg.sender != i_owner) { revert NotOwner();}
      _;  

    }

    receive() external payable { 

        fund();
    }

    fallback() external payable { 

        fund();
    }

    
}