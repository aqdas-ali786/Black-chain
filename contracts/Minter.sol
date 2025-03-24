pragma solidity ^0.8.26;

// SPDX-License-Identifier: MIT

contract Coin {
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from,address to,uint amount);

    constructor (){
        minter=msg.sender;
    }

    function mint(address reciever,uint _amount) public{
       if(msg.sender!=minter) return;
       balances[reciever] += _amount;
    }

    function send(address reciever,uint amount) public{
      if(balances[msg.sender]<amount) return;
      balances[reciever]+=amount;
      balances[msg.sender]-=amount;
        emit Sent(msg.sender, reciever, amount);
    }
}