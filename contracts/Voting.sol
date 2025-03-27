// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";

struct Voter {
    bool isRegistered;
    bool hasVoted;
    uint votedProposalId;
}

struct Proposal {
    string description;
    uint voteCount;
}

enum WorkflowStatus {
    RegisteringVoters,
    ProposalsRegistrationStarted,
    ProposalsRegistrationEnded,
    VotingSessionStarted,
    VotingSessionEnded,
    VotesTallied
}

contract Voting is Ownable{
    mapping (address => Voter) public voters;
    WorkflowStatus public currentStatus;
    Proposal[] public proposals;
    Proposal public winnerProposal;
    event VoterRegistered(address voterAddress);
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    event ProposalRegistered(uint proposalId);
    event Voted(address voter, uint proposalId);


    constructor() Ownable(msg.sender) { 
        currentStatus = WorkflowStatus.RegisteringVoters;
    }

    function registerVoter(address voter) public onlyOwner {
        require (currentStatus == WorkflowStatus.RegisteringVoters, "Registering session is not open");
        require (!voters[msg.sender].isRegistered , "Already registered.");
        voters[voter].isRegistered =true;
        emit VoterRegistered(voter);
    }

    function openProposalRegistration() public onlyOwner{
        require (currentStatus == WorkflowStatus.RegisteringVoters, "Registering session is not closed");
        currentStatus = WorkflowStatus.ProposalsRegistrationStarted;
        emit WorkflowStatusChange(WorkflowStatus.RegisteringVoters, WorkflowStatus.ProposalsRegistrationStarted);
    }
    
    function proposeProposals(string memory description) public onlyOwner {
        require (currentStatus == WorkflowStatus.ProposalsRegistrationStarted, "Proposing session is not open");
        Proposal memory proposal;
        proposal.description = description;
        proposals.push(proposal);
        uint proposalId = proposals.length -1;
        emit ProposalRegistered(proposalId);
    }

    function closeProposaRegistration () public onlyOwner{
        require (currentStatus == WorkflowStatus.ProposalsRegistrationStarted, "Registration session is not open");
        currentStatus = WorkflowStatus.ProposalsRegistrationEnded;
        emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationStarted, WorkflowStatus.ProposalsRegistrationEnded);
    }

    function startVotingSession() public onlyOwner{
        require (currentStatus == WorkflowStatus.ProposalsRegistrationEnded, "Registration session is not closed");
        currentStatus = WorkflowStatus.VotingSessionStarted;
        emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationEnded, WorkflowStatus.VotingSessionStarted);
    }
    
    function vote (address voter, uint proposalId ) public {
        require (currentStatus == WorkflowStatus.VotingSessionStarted, "Voting session is not open");
        require (voters[msg.sender].isRegistered, "you are not authorized to vote");
        require (!voters[msg.sender].hasVoted,"you already voted");
        voters[msg.sender].votedProposalId = proposalId;
        voters[msg.sender].hasVoted=true;
        proposals[proposalId].voteCount += 1;
        emit Voted(voter, proposalId);
    }

    function endVotingSession() public onlyOwner {
        require(currentStatus == WorkflowStatus.VotingSessionStarted,"Voting session is not open");
        currentStatus = WorkflowStatus.VotingSessionEnded;
        emit WorkflowStatusChange(WorkflowStatus.VotingSessionStarted, WorkflowStatus.VotingSessionEnded);
    }

    function tallyVotes() public onlyOwner returns(Proposal memory)   {
        require (currentStatus == WorkflowStatus.VotingSessionEnded,"Voting session is not closed");
        uint highestVotes = 0;
        for(uint i = 0; i < proposals.length; ++i){
            Proposal storage proposal = proposals[i];
            if (proposal.voteCount > highestVotes) {
                highestVotes = proposal.voteCount;
                winnerProposal = proposal;
            }
        }
        currentStatus = WorkflowStatus.VotesTallied;
        emit WorkflowStatusChange(WorkflowStatus.VotingSessionEnded, WorkflowStatus.VotesTallied);
        return winnerProposal;
    }

    function getWinnerProposal () view public onlyOwner returns(Proposal memory) {
        require (currentStatus == WorkflowStatus.VotesTallied, "Votes are not allied");
        return winnerProposal;
    }
}