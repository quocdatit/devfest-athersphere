    // contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract animalNftMarket is ERC721{
    using Strings for uint256;
    using Address for address;
    uint public totalAmount;
    
    
    string public domain = "http://devfest.athersphere.com/animal/detail/";
    
    
    constructor(string memory name, string memory sympol) ERC721(name, sympol){
        totalAmount = 0;
    }
    
    function tokenURI(uint256 tokenId) public view virtual override returns(string memory){
        require(_exists(tokenId), "TokenId is not availble.");
        return string(abi.encodePacked(domain, tokenId.toString()));
    } 
    
   
    event mint_after(address, uint256 tokenId, uint256 amount);
    
    function create_animal(uint256 tokenId) external payable{
        require(msg.value>0, "Animal are not free!!");
        _mint(msg.sender, tokenId);
        
        uint256 amount = msg.value * 10/100;
        address charityWallet = 0x1fD4f3460da5bD7E97d8474D119d488268d5a050;
        totalAmount = totalAmount + amount;
        sendEth(charityWallet, amount);
        emit mint_after(msg.sender, tokenId, amount);
    }
    
    // event after_sendEth(address charityWallet, uint256 eth);
    function sendEth(address charityWallet, uint256 amount) private{
        payable(charityWallet).transfer(amount);
    }
}