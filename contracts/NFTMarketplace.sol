// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTMarketplace {
    
    mapping(address => uint) public purchasedCount;
    
    struct NFT {
        string name;
        string image;
        uint price;
    }
    
    NFT[] public nfts;
    
    event NFTPurchased(address buyer, uint nftIndex);
    
    function addNFT(string memory name, string memory image, uint price) public {
        nfts.push(NFT(name, image, price));
    }
    
    function buyNFT(uint nftIndex) public payable {
        require(nftIndex < nfts.length, "Invalid NFT index");
        require(msg.value == nfts[nftIndex].price, "Insufficient funds");
        require(purchasedCount[msg.sender] < 2, "You can only purchase two NFTs");
        
        purchasedCount[msg.sender]++;
        emit NFTPurchased(msg.sender, nftIndex);
    }
    
    function getNFTCount() public view returns (uint) {
        return nfts.length;
    }
}
