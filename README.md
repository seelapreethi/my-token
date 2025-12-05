# MyToken (MTK)
## Overview

MyToken is a simple ERC-20 compatible token built on Ethereum for learning and experimentation. It supports token transfers, approvals, allowances, and event-based transparency, following the ERC-20 standard.

## Token Details

* **Name**: MyToken
* **Symbol**: MTK
* **Decimals**: 18
* **Total Supply**: 1000000000000000000000 MTK

## Features

* Standard ERC-20 implementation
* Transfer tokens between addresses
* Approve & `transferFrom` functionality
* Allowance tracking
* Event emission for transparency
* Balance management

## How to Deploy

1. Open **Remix IDE**
2. Create new file `MyToken.sol`
3. Paste the contract code
4. Compile using **Solidity 0.8.x**
5. Deploy using the desired total supply (e.g., `1000000000000000000000 * 10**18`)
## How to Use

### Check Balance

balanceOf(address account) → uint256

### Transfer Tokens

transfer(address to, uint256 amount) → bool


### Approve Spender
approve(address spender, uint256 amount) → bool

### Check Allowance

allowance(address owner, address spender) → uint256

### Transfer Using Allowance

transferFrom(address owner, address to, uint256 amount) → bool


## Events

event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);


## Example Remix Console Commands

**Check your balance**
balanceOf(msg.sender)


**Transfer 10 MTK**
transfer("0xRecipient", 10 ether)


**Approve spender**
approve("0xSpender", 50 ether)

**Spender transfers using allowance**
transferFrom("0xOwner", "0xReceiver", 20 ether)

