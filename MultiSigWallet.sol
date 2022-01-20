pragma solidity 0.8.11;

contract MultiSigWallet {

    // these constants you should input yourself
    address[] owners = [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2];
    uint signLimit = 3;

    // structure of a transfer
    struct Transfer {
        address initiater;
        uint amount;
        address payable recipient;
        bool confirmed;
        address[] signers;
    }

    // balance and all transfers
    uint balance = 0;
    Transfer[] transfers;

    // deposit Ethereum to the protocol
    function deposit() public payable {
        require(msg.value > 0);
        balance += msg.value;
    }

    // amount in WEI!!!!
    function transfer(address payable recipient, uint amount) public {
        require(addressIsOwner(msg.sender), "you are not the owner");
        Transfer memory newTransfer;
        newTransfer.initiater = msg.sender;
        newTransfer.amount = amount;
        newTransfer.recipient = recipient;
        newTransfer.confirmed = false;

        // we cant just push msg.sender to newTransfer.signers cause newTransfer is memory. not storage
        // after we created a new trasfer, we can easily add msg.senders to last created transfer
        transfers.push(newTransfer);
        transfers[transfers.length - 1].signers.push(msg.sender);
    }

    // is 3 accours, then call confirm
    function sign(uint transferIndex) public payable {
        Transfer storage currentTransfer = transfers[transferIndex];
        if (addressSigned(msg.sender, currentTransfer.signers) == false) {
            currentTransfer.signers.push(msg.sender);
        }

        // check if already needed amount of signatures to transfer money
        if (currentTransfer.signers.length >= signLimit) {
            currentTransfer.recipient.transfer(currentTransfer.amount);
            balance -= currentTransfer.amount;
            currentTransfer.confirmed = true;
        }
    }

    // PRINT SOME INFO //

    function getBalance() public view returns(uint) {
        return balance;
    }

    function numberOfTranfers() public view returns(uint) {
        return transfers.length;
    }

    function statusOfTransfer(uint indexOfTransfer) public view returns(bool) {
        return transfers[indexOfTransfer].confirmed;
    }

    // HELPER FUNCTIONS //

    // check if address is already signed transfer by checking existance in array
    function addressSigned(address signer, address[] memory signers) private pure returns(bool) {
        for (uint i = 0; i < signers.length; i++) {
            if (signers[i] == signer) {
                return true;
            }
        }
        return false;
    }

    function addressIsOwner(address currentAddress) private view returns(bool) {
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == currentAddress) {
                return true;
            }
        }
        return false;
    }
}
