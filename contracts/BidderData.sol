pragma solidity ^0.8.26;

// SPDX-License-Identifier: MIT

contract Bidder {
    string public name="Aqdas";
    uint public bidAmount;
    bool public eligible;
    uint constant minBid=1000;

    function setName(string memory _name) public{
       name=_name;
    }

    function setBidAmount(uint amount) public{
        bidAmount=amount;
    }

    function determineEligibility() public{
       if(bidAmount >= minBid) eligible = true;
       else eligible=false;
    }
}