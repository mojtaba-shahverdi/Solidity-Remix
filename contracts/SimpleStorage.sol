// SPDX-License-Identifier: MIT
pragma solidity >=0.8.8 <0.9.0;

// types:
    //  bool hasFavNumber = true;
    //  string favNum = "five";
    //  int256 favInt = -5;
    //  address myWallet = 0xad31A4238aE747DD85b736F8E3E6aDD8430DA38d;
    //  bytes32 favBytes = "dog";
    //  uint256 favNumber = 8;

contract SimpleStorage {

     uint256 favNumber;

     mapping(string => uint256) public nameToFavNumber;

     struct People {
         uint256 favNumber;
         string name;
     }
     
    //  uint256[] public favNumbersList; we can do the same thing we did below right here
     People[] public people;

     function store(uint256 _favNumber) public virtual  {
         favNumber = _favNumber;
     }

     function retrieve() public view returns(uint256)  {
         return favNumber;
     }

     function addPerson(string memory _name, uint _favNumber) public {
        //  People memory newPerson = People({favNumber: _favNumber, name: _name}); or:
        //  People memory newPerson = People(_favNumber, _name);
        //  people.push(newPerson); or:
         people.push(People(_favNumber, _name));
         nameToFavNumber[_name] = _favNumber;
     }
}

// 0xd9145CCE52D386f254917e481eB44e9943F39138