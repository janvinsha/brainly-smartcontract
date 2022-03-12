
// pragma solidity ^0.8.7;

// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Strings.sol";


// contract Brainly is ERC1155, Ownable {
//   using Counters for Counters.Counter;
//      Counters.Counter public _noUsers;
//     mapping (uint256 => string) private _uris;
//     mapping(uint256 => address) private userLevels;
//       address[] userAddresses;

//     constructor() public ERC1155("https://gateway.pinata.cloud/ipfs/QmTJdTgwvDLn4VRGmion2ow84y4exj4SPKjNcwGpiDxuAe/{id}.json") {
//         _mint(msg.sender, 0, 1, "");
//     }
         
//      struct User {
//          uint256 userId;
//          address userAddress;
//          uint256 level;
//      }

//     mapping(uint256 => User) private idToUser;
//     mapping(address => User) private addressToUser;
    
//     function uri(uint256 tokenId) override public view returns (string memory) {
//         return(_uris[tokenId]);
//     }
    
//     function setTokenUri(uint256 tokenId, string memory uri) public onlyOwner {
//         require(bytes(_uris[tokenId]).length == 0, "Cannot set uri twice"); 
//         _uris[tokenId] = uri; 
//     }

//         function fetchUsers() public view returns (User[] memory) {
//         uint256 userCount = _noUsers.current();
//         uint currentIndex = 0;

//           User[] memory users = new User[](userCount);
//         for (uint i = 0; i < userAddresses.length; i++) {      
//                 address currentAddress=userAddresses[i];
//                 User storage currentItem = addressToUser[currentAddress];
//                 users[currentIndex] = currentItem;
//                 currentIndex += 1;        
//         }
//         return users;
//     }

//       function mintMembershipNFT() public {
    
//              _noUsers.increment();

//              _mint(msg.sender, 0, 1, "");

//             addressToUser[msg.sender] = User(
//                  _noUsers.current(),
//                     msg.sender,
//                 0   
//             );
//             userAddresses.push(msg.sender);
//      }

//       function publish(uint256 _level) public{
 
//         require(addressToUser[msg.sender].userAddress!=address(0),"Mint membership token to be able to min");
//         addressToUser[msg.sender]=User(
//                  _noUsers.current(),
//                     msg.sender,
//                 _level
//             );
//       }

//       function isMember() public view returns (bool _bool){
//           for (uint i=0; i< userAddresses.length;i++){
//           if(userAddresses[i]==msg.sender){
//             return true;
//           }    
//       }
//           return false;

//       }

// }



//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract Brainly is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
     Counters.Counter public _noUsers;

      address[] userAddresses;
 event NewEpicNFTMinted(address sender, uint256 tokenId);
    constructor() ERC721("Brainly Membership Token", "BMT") {
        // _setBaseURI("ipfs://");
    }

         struct User {
         uint256 userId;
         address userAddress;
         uint256 level;
     }

    mapping(uint256 => User) private idToUser;
    mapping(address => User) private addressToUser;

            function fetchUsers() public view returns (User[] memory) {
        uint256 userCount = _noUsers.current();
        uint currentIndex = 0;

          User[] memory users = new User[](userCount);
        for (uint i = 0; i < userAddresses.length; i++) {      
                address currentAddress=userAddresses[i];
                User storage currentItem = addressToUser[currentAddress];
                users[currentIndex] = currentItem;
                currentIndex += 1;        
        }
        return users;
    }

 
          function mintToken() public
    returns (uint256){
             _noUsers.increment();
               _tokenIds.increment();
           uint256 id = _tokenIds.current();
            addressToUser[msg.sender] = User(
                 _noUsers.current(),
                    msg.sender,
                0   
            );
            userAddresses.push(msg.sender);
         _safeMint(msg.sender, id);
        _setTokenURI(id, "https://gateway.pinata.cloud/ipfs/QmTJdTgwvDLn4VRGmion2ow84y4exj4SPKjNcwGpiDxuAe/0.json");
            emit NewEpicNFTMinted(msg.sender,id);
           return id;
     }

      function publish(uint256 _level) public{
 
        require(addressToUser[msg.sender].userAddress!=address(0),"Mint membership token to be able to min");
        addressToUser[msg.sender]=User(
                 _noUsers.current(),
                    msg.sender,
                _level
            );
      }

          function isMember() public view returns (bool _bool){
          for (uint i=0; i< userAddresses.length;i++){
          if(userAddresses[i]==msg.sender){
            return true;
          }    
      }
          return false;

      }
}
