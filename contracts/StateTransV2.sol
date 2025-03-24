// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract StateTransV2 {
    enum Stage {Init,Reg,Vote,Don}
    Stage public stage;
    uint startTime;
    uint public timeNow;
    
    constructor(){
       stage=Stage.Init;
       startTime=block.timestamp;
    }

    function advanceState() public {
        timeNow=block.timestamp;
        if(timeNow>(startTime+10 seconds)){
           startTime=timeNow;
           if(stage==Stage.Init) {stage=Stage.Reg; return;}
           if(stage==Stage.Reg) {stage=Stage.Vote; return;}
           if(stage==Stage.Vote) {stage=Stage.Vote; return;}
           return ;
        }
    }
}