
# **CryptoWaifus TON root API**

The most primitive NFT token in FreeTON.
Inspired by Crypto Punks.  But it is better not to make tokens using this contract any more.
Use TIP-3 instead.


## Table of Contents

* [Variables](#variables)
	* [name](#name)
	* [symbol](#symbol)
	* [totalSupply](#totalSupply)
	* [decimals](#decimals)
	* [nextWaifuIndexToAssign](#nextWaifuIndexToAssign)
	* [waifusRemainingToAssign](#waifusRemainingToAssign)
	* [mintFee](#mintFee)
	* [imageUrl](#imageUrl)
	* [basicFee](#basicFee)
*  [Structs](#structs)
	* [Meta](#Meta)
	* [Offer](#Offer)
	* [Bid](#Bid)
* [Mapping](#mapping)
	* [balanceOf](#balanceOf)
	* [OwnerOf](#OwnerOf)
	* [keysToWallet](#keysToWallet)
	* [waifusOfferedForSale](#waifusOfferedForSale)
	* [waifusMeta](#waifusMeta)
	* [waifuBids](#waifuBids)
	* [pendingWithdrawals](#pendingWithdrawals)
*  [Events](#events)
*	[Error Codes](#error-codes)
* [Functions](#functions)
	* [mint()](#mint)
	* [changeUserWallet()](#changeuserwallet)
	* [WithdrawFees()](#withdrawfees)
	* [TransferAdmin()](#transferadmin)
	* [SetBasicFee()](#setbasicfee)
	* [SetMintFee()](#setmintfee)
	* [SetImageUrl()](#setimageurl)
	* [BurnTotalSupply()](#burntotalsupply)
	* [getWaifu()](#getwaifu)
	* [getOffer()](#getoffer)
	* [getBid()](#getbid)
	* [getWaifuAllData()](#getwaifualldata)
	* [getPendingWithdrawal()](#getpendingwithdrawal)
	* [getBalance()](#getbalance)
	* [getLatestWaifus()](#getlatestwaifus)
	* [getWaifusInRange()](#getwaifusinrange)
	* [getWaifusByOwner()](#getwaifusbyowner)
	* [getActiveOffers()](#getactiveoffers)
	* [getActiveBids()](#getactivebids)
	* [getUserWallet()](#getuserwallet)
	* [setName()](#setname)
	* [transferWaifu()](#transferwaifu)
	* [waifuNoLongerForSale()](#waifunolongerforsale)
	* [offerWaifuForSale()](#offerwaifuforsale)
	* [buyWaifu()](#buywaifu)
	* [withdraw()](#withdraw)
	* [enterBidForWaifu()](#enterbidforwaifu)
	* [acceptBidForWaifu()](#acceptbidforwaifu)
	* [withdrawBidForWaifu()](#withdrawbidforwaifu)


## Detailed description

### Variables
```
string  public name;
```
```
string  public symbol;
```
```
uint256  public totalSupply;
```
```
uint8  public decimals;
```
```
uint256  public nextWaifuIndexToAssign = 0;
```
  
```
uint256  public waifusRemainingToAssign = 0;
```
  
```
uint128  public mintFee;
```
  
```
string  public imageUrl;
```
  
```
uint128  public basicFee;
```

### Structs
```
struct  Meta{
	uint256 owner;
	string name;
	uint64 mintTimestamp;
	bool isForSale;
	bool hasBid;
}
```
  
```
struct  Offer {
	bool isForSale;
	uint256 waifuIndex;
	uint256 seller;
	uint128 minValue;
}
```
  
```
struct  Bid {
	bool hasBid;
	uint256 waifuIndex;
	uint256 bidder;
	uint128 value;
}
```

### Mapping
```
mapping (uint256 => uint128) public balanceOf;
mapping (uint256 => uint256[]) public OwnerOf;
mapping (uint256 => address) public keysToWallet;
mapping (uint256 => Offer) public waifusOfferedForSale;
mapping (uint256 => Meta) public waifusMeta;
mapping (uint256 => Bid) public waifuBids;
mapping (uint256 => uint128) public pendingWithdrawals;
```
### Events
```
event  eTransfer(uint256 from, uint256 to, uint256 waifuIndex);
event  eWaifuNoLongerForSale(uint256 waifuIndex);
event  eWaifuOffered(uint256 waifuIndex, uint128 minSalePrice, uint256 to);
event  eWaifuBought(uint256 waifuIndex, uint128 price, uint256 seller, uint256 byuer);
event  eWaifuBidEntered(uint256 waifuIndex, uint128 price, uint256 bidder);
event  eWaifuBidWithdrawn(uint256 waifuIndex, uint128 price, uint256 bidder);
event  eWaifuNameChanged(uint256 waifuIndex, string name);
```
### Error Codes
```
1** - standard errors
*********************
101 - Not authorized to administer
102 - ID is already taken
103 - Invalid user key for a private transaction
*********************

2** - Buying
*********************
201 - not enough money
202 - don't exist this waifu
203 - Not big enough new bet
204 - User isn't the owner
205 - User isn't the bidder
206 - Byuer is owner
207 - Waifu isn't for sell
208 - Seller no longer owner of waifu
209 - No owner
210 - Minimum fee is not provided
*********************

3** - overflow errors
*********************
301 - maximum amount overflow waifus
302 - string byteLength too high
*********************
```


### Functions
This chapter describes all the functions of a smart contract
#### mint
This function creates a new token. 
msg.value >= mintFee needs to be provided
```Crypto Waifus
function mint(uint256 userKey) external
```
#### changeUserWallet
Associate user key and waifus wallet address 
```Crypto Waifus
function  changeUserWallet(uint256 userKey, address newwallet) external
```
#### WithdrawFees
Admin function withdraws fees
```Crypto Waifus
function  WithdrawFees(address destination) public
```
#### TransferAdmin
Admin function transfers admin
```Crypto Waifus
function  TransferAdmin(uint256 newadmin) public
```
#### SetBasicFee
```Crypto Waifus
function  SetBasicFee(uint128 newfee) public
```
#### SetMintFee
```Crypto Waifus
function  SetMintFee(uint128 newfee) public
```
#### SetImageUrl
```Crypto Waifus
function  SetImageUrl(string newurl) public
```
#### BurnTotalSupply
Limits tokens amount
```Crypto Waifus
function  BurnTotalSupply(uint256 newsupply) public
```
#### getWaifu
Returns waifu's meta
```Crypto Waifus
function  getWaifu(uint256 waifuIndex) public  view  returns(Meta m)
```
#### getOffer
Retruns waifu offer
```Crypto Waifus
function  getOffer(uint256 waifuIndex) public  view  returns(Offer o)
```
#### getBid
Returns waifu bid
```Crypto Waifus
function  getBid(uint256 waifuIndex) public  view  returns(Bid b)
```
#### getWaifuAllData
Returns waifu's meta, offer and bid
```Crypto Waifus
function  getWaifuAllData(uint256 waifuIndex)public  view  returns(Meta m, Offer o, Bid b)
```
#### getPendingWithdrawal
Get user's freezed balance
```Crypto Waifus
function  getPendingWithdrawal(uint256 owner) public  view  returns(uint128 amount)
```
#### getBalance
Get count of user's waifus
```Crypto Waifus
function  getBalance(uint256 owner) public  view  returns(uint128 amount)
```
#### getLatestWaifus
Get metas of N latest waifus
```Crypto Waifus
function  getLatestWaifus(uint256  N) public  view  returns(mapping(uint256 => Meta))
```
#### getLatestWaifus
```Crypto Waifus
Get metas of Start to End waifus
function  getWaifusInRange(uint256 start, uint256 end) public  view  returns(mapping(uint256 => Meta))
```
#### getWaifusByOwner
Get waifus owned by specified user
```Crypto Waifus
function  getWaifusByOwner(uint256 owner) public  view  returns(mapping(uint256 => Meta))
```
#### getActiveOffers

```Crypto Waifus
function  getActiveOffers(uint256  N) public  view  returns(mapping(uint256 => Offer))
```
#### getActiveBids
```Crypto Waifus
function  getActiveBids(uint256  N) public  view  returns(mapping(uint256 => Bid))
```
#### getUserWallet 
Waifus wallet smart contract address
```Crypto Waifus
function  getUserWallet (uint256 userKey) public  view  returns(address sc)
```
#### setName
Sets waifus name.
Needs Value provided >= basicFee
If you are using JS SDK,  encode name to hex: `Buffer.from("My girl").toString("hex")`
```Crypto Waifus
function  setName(uint256 owner, uint256 waifuIndex, string newname) external 
```
#### transferWaifu
Needs Value provided >= basicFee
```Crypto Waifus
function  transferWaifu(uint256 from, uint256 to, uint256 waifuIndex) external
```
#### waifuNoLongerForSale
Cancel waifu offer
```Crypto Waifus
function  waifuNoLongerForSale(uint256 waifuIndex) public 
```
#### offerWaifuForSale
Offers waifu for sale
Needs Value provided >= basicFee
```Crypto Waifus
function  offerWaifuForSale(uint256 from,uint256 waifuIndex, uint128 minSalePrice) external
```
#### buyWaifu
Needs Value provided >= minSalePrice
```Crypto Waifus
function  buyWaifu(uint256 userKey, uint256 waifuIndex) external 
```
#### withdraw
Withdraw freezed funds to address
```Crypto Waifus
function  withdraw(address destination)public
```
#### enterBidForWaifu
Needs msg.value provided = bid Value + basicFee
```Crypto Waifus
function  enterBidForWaifu(uint256 userKey, uint256 waifuIndex) external
```
#### acceptBidForWaifu
Accept bid by the owner
```Crypto Waifus
function  acceptBidForWaifu(uint256 waifuIndex, uint128 minPrice) public  
```
#### acceptBidForWaifu
Cancel bid by the bidder
```Crypto Waifus
function  withdrawBidForWaifu(uint256 waifuIndex) public 
```
