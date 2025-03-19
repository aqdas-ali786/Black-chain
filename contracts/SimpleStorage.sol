// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleStorage {
    uint storedData;

    constructor() {
        storedData=0;
    }

    function set(uint x)public  {
        storedData=x;
    }

    function get() public view returns (uint) {
        return storedData;
    }

    function increment(uint n)public  {
        storedData=storedData+n;
    }

    function decrement(uint n)public  {
        storedData=storedData-n; 
    }
}