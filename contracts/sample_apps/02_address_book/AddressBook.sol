// SPDX-License-Identifier: MIT
//
// https://cryptomarketpool.com/address-book

pragma solidity ^0.8.0;

// This is a smart contract allows one to store a list of contact addressess under their own address
//each contact address stored under the owner's address con be given an alias name, this is a nested mapping in solidity. 

contract AddressBook {
    // stores a list/array of contact address under the owner's address
    mapping(address => address[]) private contacts;

    //Each contact address under the owner's address can be given an alias Name
    mapping(address => mapping(address => string)) private aliases;

    // Returns a list/array of addressess stored under my address
    function getContacts() public view returns (address[] memory) {
        return contacts[msg.sender];
    }

    // You can add contactAddress to your array and give it an alias name 
    function addContact(address contactAddress, string memory aliasName) public {
        contacts[msg.sender].push(contactAddress);
        aliases[msg.sender][contactAddress] = aliasName;
    }

    // Allows you see the alias name that a particular contactAddress has. 
    function getAlias(address contactAddress) public view returns (string memory) {
        return aliases[msg.sender][contactAddress];
    }

    // remove the alias name of a particular contactAddress from my array. 
    function removeContact(address contactAddress) public {
        uint256 length = contacts[msg.sender].length;
        for (uint256 i = 0; i < length; i++) {
            // Rather compare each contact address in the current user array to the specified contactAddress from input function.
            if (contacts[msg.sender][i] == contactAddress) {

                // Check for overflow and underflow even though we are using solidity 0.8
                if (contacts[msg.sender].length > 1 && i < length - 1) {

                    // Shift the item to be removed to the last element in my list. 
                    contacts[msg.sender][i] = contacts[msg.sender][length - 1];
                }
                // Remove the last item in my list. 
                contacts[msg.sender].pop();

                // Remove alias name of the deleted contactAddress. 
                delete aliases[msg.sender][contactAddress];
                break; // Stop the loop. 
            }
        }
    }
}
