pragma solidity ^0.8.26;

// SPDX-License-Identifier: MIT

contract BallotV2{
    struct Voter{
        uint weight;
        bool voted;
        uint8 vote;
    }
    struct Proposal{
        uint voteCount;
    }
    enum Stage{Init,Reg,Vote,Done}
    Stage public stage=Stage.Init;

    address chairPerson;
    mapping (address=>Voter) voters;
    Proposal[] proposals;

    uint startTime;

    constructor(uint8 _numProposals) {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 2;
        for (uint8 i = 0; i < _numProposals; i++) {
            proposals.push(Proposal(0));
        }
        stage=Stage.Reg;
        startTime=block.timestamp;
    }

   function register(address toVoter) public{
        if(stage!=Stage.Reg) return; 
        if(msg.sender != chairPerson || voters[toVoter].voted) return;
        voters[toVoter].weight = 1;
        voters[toVoter].voted = false;
        if(block.timestamp>(startTime+10 seconds)){
            stage=Stage.Vote;
            startTime=block.timestamp;
        }
    }

    function vote(uint8 toProposal) public{
        if(stage!=Stage.Vote){return;}
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
        if(block.timestamp>(startTime+10 seconds)){stage=Stage.Done;}
    }

    function winningProposal() public view returns (uint8 _winningProposal) {
        if(stage!=Stage.Done) { return type(uint8).max; }
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
    }

}