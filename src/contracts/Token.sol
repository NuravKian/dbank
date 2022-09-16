// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;
  
  //add minter changed event
  event MinterChanged(address indexed minter, address new_minter);
  constructor() payable ERC20("Decentralized Bank Currency", "DBC") {
    minter = msg.sender;
   
  }

  //Add pass minter role function
  function passMinterRole(address new_minter) public returns(bool){
    require(minter == msg.sender);
    minter = new_minter;

    emit MinterChanged(minter,new_minter);

    return true;
  }
  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(minter == msg.sender,"Not the Minter");
		_mint(account, amount);
	}
}