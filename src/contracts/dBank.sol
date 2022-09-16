// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract dBank {

  //assign Token contract to variable
  Token private token;
  //add mappings
  mapping(address => uint) public etherBalancesOf;
  mapping(address => uint) public depositStart;
  mapping(address => bool) public isDeposited;

  //add events
  event Deposit(address indexed user, uint etherAmount, uint timeStart);
  event Withdraw(address indexed user, uint userBalance, uint depositTime, uint interest);
  //pass as constructor argument deployed Token contract
  constructor(Token _token) public {
    //assign token deployed contract to variable
    token = _token;
  }

  function deposit() payable public {
  
    //check if msg.sender didn't already deposited funds
    //check if msg.value is >= than 0.01 ETH
    require(isDeposited[msg.sender]== false);
    require(msg.value >= 1e16,'error, value deposited must be more than .01 eth');

    //increase msg.sender ether deposit balance
    //start msg.sender hodling time
    etherBalancesOf[msg.sender] = etherBalancesOf[msg.sender] + msg.value;
    depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;
    isDeposited[msg.sender] = true;

    emit Deposit(msg.sender, msg.value, block.timestamp);
    //emit Deposit event

  }

  function withdraw() public {
    //check if msg.sender deposit status is true
    require(isDeposited[msg.sender]==true);

    //assign msg.sender ether deposit balance to variable for event
    uint ethDeposit = etherBalancesOf[msg.sender];

    //check user's hodl time
    uint depositTime = block.timestamp - depositStart[msg.sender];
    //calc interest per second
    uint interestPerSecond = 31668017 * (etherBalancesOf[msg.sender] /1e16);
    uint interest = interestPerSecond * depositTime;
    //calc accrued interest

    //send eth to user
    msg.sender.transfer(ethDeposit);
   
    //send interest in tokens to user
    token.mint(msg.sender,interest);

    //reset depositer data
    etherBalancesOf[msg.sender] = 0;
    isDeposited[msg.sender] = false;
    depositStart[msg.sender] = 0;
    //emit event
    emit Withdraw(msg.sender,ethDeposit,depositTime,interest);
  }

  function borrow() payable public {
    //check if collateral is >= than 0.01 ETH
    //check if user doesn't have active loan

    //add msg.value to ether collateral

    //calc tokens amount to mint, 50% of msg.value

    //mint&send tokens to user

    //activate borrower's loan status

    //emit event
  }
  function etherBalanceOf(address user) public view returns(uint){
    return etherBalancesOf[user];
  }
  function payOff() public {
    //check if loan is active
    //transfer tokens from user back to the contract

    //calc fee

    //send user's collateral minus fee

    //reset borrower's data

    //emit event
  }
}