

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
  event SetName(string name);
   event Publish(uint256 level);
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
    mapping(address=>string) private Names;

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
            emit Publish(_level);
      }

          function isMember() public view returns (bool _bool){
          for (uint i=0; i< userAddresses.length;i++){
          if(userAddresses[i]==msg.sender){
            return true;
          }    
      }
          return false;

      }

      function getUser(address userAddress) public view returns (User memory){
          return (addressToUser[userAddress]);
      }

      function getName(address userAddress) public view returns(string memory){
      return Names[userAddress];
      }

       function setName(string memory name) public{
           Names[msg.sender] = name;
           emit SetName(Names[msg.sender]);
      }

      function fetchUserAddresses() public view returns(address[] memory){
          return userAddresses;
      }
}
