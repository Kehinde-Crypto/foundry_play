// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../lib/forge-std/src/Vm.sol";
import "../src/NFT.sol";

contract NFTTest is Test {
    NFT nft;
    address owner = address("");
    address buyer = address("");

    function setUp() public {
        nft = new NFT();
    }

    function testMint() public {
        nft.mint(owner, 1);
        assertEq(nft.balanceOf(owner), 1);
        assertEq(nft.ownerof(1), owner);
    }

    function testBuyNFT() public {
        nft.mint(owner, 1);

        // Simulate the buyer sending 0.01 ether to buy the NFT
        vm.deal(buyer, 1 ether);
        vm.prank(buyer);
        bool success = nft.buyNFT{value: 0.01 ether}(1, owner, buyer);

        assertTrue(success);
        assertEq(nft.ownerOf(1), buyer);
        assertEq(owner.balance, 0.01 ether);
    }

    function testFailBuyNFTInsufficientFunds() public {
        nft.mint(owner, 1);

        // Simulate the buyer sending less than 0.01 ether to buy the NFT
        vm.deal(buyer, 1 ether);
        vm.prank(buyer);
        nft.buyNFT{value: 0.005 ether}(1, owner, buyer);
    }
}
