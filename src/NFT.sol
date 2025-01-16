// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "../lib/forge-std/src/interfaces/IERC721.sol";
import "../";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// interface IERC721 {
//     function balanceOf(address _owner) external view returns (uint256);

//     function ownerof(uint256 _tokenId) external view returns (address);

//     function safeTransferFrom(
//         address _from,
//         address _to,
//         uint256 _tokenId,
//         bytes memory _data
//     ) external;

//     function transferFrom(address from, address to, uint256 tokenId) external;

//     function approve(address _approved, uint256 _tokenId) external;

//     function getApproved(uint256 _tokenId) external view returns (address);
// }

abstract contract ERC721Tradable is IERC721 {
    event TokenPurchased(
        uint256 _tokenId,
        address _value,
        address _owner,
        address _buyer
    );

    // This function checks if the user has enough funds and returns a boolean and address
    function nfts(
        uint256 _idUser,
        address _buyer
    ) external pure returns (bool, address) {
        // You likely want to check the buyer's balance or some other logic, not the user ID here
        require(_buyer != address(0), "Invalid buyer address");
        // Add logic to interact with a balance or NFT verification if needed
        return (true, _buyer); // Dummy return
    }

    // The function to handle buying the NFT, requiring at least 0.01 ether
    function buyNFT(
        uint256 _tokenId,
        address _owner,
        address _buyer
    ) public payable returns (bool) {
        // Ensure the buyer is sending enough ether (at least 0.01 ether)
        require(msg.value >= 0.01 ether, "Insufficient funds to buy the NFT");

        // Additional logic like transferring the NFT to the buyer could go here
        // e.g., _safeTransfer(_owner, _buyer, _tokenId, "");

        // After the NFT is transferred, you would send the funds to the owner
        payable(_owner).transfer(msg.value);

        // Emit an event for the purchase (optional but recommended)
        emit TokenPurchased(
            _tokenId,
            address(uint160(msg.value)),
            _owner,
            _buyer
        );

        return true; // Return success
    }
}

contract NFT is ERC721Tradable {
    constructor() ERC721("NFT", "NFT") {}

    function mint(address _to, uint256 _tokenId) public {
        _mint(_to, _tokenId);
    }
}
