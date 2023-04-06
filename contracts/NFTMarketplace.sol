// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract NFTMarketplace {
  mapping(address => NFTAssociated) public association;
    struct NFT {
        string name;
        string image;
        uint price;
        address owner;
    }

    struct NFTAssociated{
        uint purchasedCount;
        NFT[] nfts;
    }
    
    NFT[] public nfts;
    
    event NFTPurchased(address buyer, uint nftIndex);
    
    function addNFT(string memory name, string memory image, uint price) public {
        nfts.push(NFT(name, image, price, address(0)));
    }
    
    function buyNFT(uint nftIndex) public payable {
        require(nftIndex < nfts.length, "Invalid NFT index");
        require(msg.value == nfts[nftIndex].price, "Insufficient funds");
        require(association[msg.sender].purchasedCount < 2, "You can only purchase two NFTs");
        nfts[nftIndex].owner = msg.sender;
        association[msg.sender].purchasedCount++;
        association[msg.sender].nfts.push(nfts[nftIndex]);
        emit NFTPurchased(msg.sender, nftIndex);
    }
    
    function getNFTCount() public view returns (uint) {
        return nfts.length;
    }

    function getNFTs() public view returns (NFT[] memory) {
        return nfts;
    }

    function getNFTbyIndex(uint nftIndex) public view returns (string memory, string memory, uint, address) {
        require(nftIndex < nfts.length, "Invalid NFT index");
        NFT memory nft = nfts[nftIndex];
        return (nft.name, nft.image, nft.price, nft.owner);
    }

    function getNFTsByOwner() public view returns (NFT[] memory) {
        return association[msg.sender].nfts;
    }
}
