// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

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

    function getNFTs() public view returns (NFT[] memory) {
        return nfts;
    }

    function getNFTbyIndex(uint nftIndex) public view returns (string memory, string memory, uint) {
        require(nftIndex < nfts.length, "Invalid NFT index");
        NFT memory nft = nfts[nftIndex];
        return (nft.name, nft.image, nft.price);
    }
}
