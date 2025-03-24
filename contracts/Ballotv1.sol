pragma solidity ^0.8.26;

// SPDX-License-Identifier: MIT

contract BallotV1{
    struct Voter{
        uint weight;
        bool voted;
        uint8 vote;
    }
    struct Proposal{
        uint voteCount;
    }
    address chairPerson;
    mapping (address=>Voter) voters;
    Proposal[] proposals;

    constructor(uint8 _numProposals) {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 2;
        for (uint8 i = 0; i < _numProposals; i++) {
            proposals.push(Proposal(0));
        }
    }

   function register(address toVoter) public{
        if(msg.sender != chairPerson || voters[toVoter].voted) return;
        voters[toVoter].weight = 1;
        voters[toVoter].voted = false;
    }

    function vote(uint8 toProposal) public{
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
    }

}