// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Casino  {
    address internal owner;

    mapping(string => address[]) public playersByColor;

    mapping(address => uint) internal playerBetAmounts;
    
    mapping(string => uint) public totalBetAmountsByColor;
    
    string public lastWin;


    constructor() {
        owner = msg.sender;
    }

    function bet(string calldata color) external payable {
        require(msg.value >= .015 ether);

        uint betAmount = playerBetAmounts[msg.sender];
        if (betAmount == 0) {
            playersByColor[color].push(msg.sender);    
        }
        
        playerBetAmounts[msg.sender] = betAmount + msg.value;
        uint _totalBet = totalBetAmountsByColor[color];
        totalBetAmountsByColor[color] = _totalBet + msg.value;
    }

    function pickWinner(string calldata color) external {
        require(msg.sender == owner);

        address[] memory _winners = playersByColor[color];
        lastWin = color;
        

        for (uint i = 0; i < _winners.length; i++ ) {
            address _winner = _winners[i];
            (bool sent, bytes memory data) = _winner.call{value: playerBetAmounts[_winner] * 2}("");
            require(sent, "Failed to send Ether");
        }
    }
    
    function getNumberOfplayersByColor(string calldata color) external view returns(uint) {
        return playersByColor[color].length;
    }
    
    function getTotalBetAmounts() external view returns(uint, uint, uint) {
        return (totalBetAmountsByColor['red'], totalBetAmountsByColor['yellow'], totalBetAmountsByColor['blue']);
    }

    
    function getLastWin() external view returns(string memory) {
        return lastWin;
    }
}
