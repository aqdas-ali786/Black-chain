// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Greeter {
    string public yourName;

    constructor() {
        yourName = "Aqdas";
    }

    function set(string memory name) public {
        yourName = name;
    }

    function hello() public view returns (string memory) {
        return yourName;
    }
}
