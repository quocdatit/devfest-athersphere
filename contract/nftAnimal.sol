// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract animalNftMarket is ERC721{
    
    using Address for address;
    using Strings for uint256;
    
    string public domain = "http://103.153.214.201:3000/animal/detail/";
    
    constructor(string memory name, string memory sympol) ERC721(name, sympol){}
    
    function tokenURI(uint256 tokenId) public view virtual override returns(string memory){
        require(_exists(tokenId), "TokenId is not availble.");
        return string(abi.encodePacked(domain, tokenId.toString()));
    } 
    
    event mint_after(address, uint256 tokenId);
    
    function create_animal(uint256 tokenId) external payable{
        require(msg.value>0, "Animal are not free!!");
        _mint(msg.sender, tokenId);
        emit mint_after(msg.sender, tokenId);
    }
}