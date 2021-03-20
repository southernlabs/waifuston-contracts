pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "ICryptoWaifu.sol";

contract CryptoWaifuWallet {
    /*
     Exception codes:
      100 - message sender is not a wallet owner.
      101 - invalid transfer value.
    */

    address waifuRoot;

    /// @dev Contract constructor.
    constructor(address root) public {
        // check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        waifuRoot = root;
    }


    // Modifier that allows function to accept external call only if it was signed
    // with contract owner's public key.
    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    /// @dev Allows to transfer tons to the destination account.
    /// @param dest Transfer target address.
    /// @param value Nanotons value to transfer.
    /// @param bounce Flag that enables bounce message in case of target contract error.
    function sendTransaction(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
         // Runtime function that allows to make a transfer with arbitrary settings.
        dest.transfer(value, bounce, 0);
    }

    function setRoot(address _waifuRoot) public checkOwnerAndAccept{
        waifuRoot = _waifuRoot;
    }



    function mint(uint userKey) external view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).mint{value: 10000000000}(userKey);
    }

    function mintPrice(uint userKey, uint128 value) external view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).mint{value: value}(userKey);
    }

    function transfer(uint256 to, uint256 waifuIndex,uint128 fee) public view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).transferWaifu{value: fee}( tvm.pubkey(),to, waifuIndex);
    }

    // Price (Fee must be included)
    function bid(uint userKey, uint256 waifuIndex, uint128 price) external view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).enterBidForWaifu{value: price}(userKey, waifuIndex);
    }

    function buy(uint userKey, uint256 waifuIndex, uint128 price) external view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).buyWaifu{value: price}(userKey, waifuIndex);
    }

    // Offer for sale
    function offer( uint256 waifuIndex,uint128 price,uint128 fee) external view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).offerWaifuForSale{value:fee}(tvm.pubkey(),waifuIndex,price);
    }

    function setName( uint256 waifuIndex,string name,uint128 fee) external view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).setName{value:fee}(tvm.pubkey(),waifuIndex,name);
    }

    function registerWallet(address wallet,uint128 fee) external view checkOwnerAndAccept{
        ICryptoWaifu(waifuRoot).changeUserWallet{value: fee}(tvm.pubkey(), wallet);
    }

}