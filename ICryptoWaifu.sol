pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

interface ICryptoWaifu {
    function mint(uint userKey) external;
    function changeUserWallet(uint256 userKey, address newwallet) external;
    function transferWaifu(uint256 from, uint256 to, uint256 waifuIndex) external;
    function enterBidForWaifu(uint userKey, uint256 waifuIndex) external;
    function buyWaifu(uint userKey,uint256 waifuIndex) external;
    function offerWaifuForSale(uint256 from,uint256 waifuIndex, uint128 minSalePrice) external;
    function setName(uint256 owner, uint256 waifuIndex, string name) external;
}