pragma solidity ^0.4.0;

contract NFTtrading {
    
    uint public user_cnt = 0; // record the users
    mapping(uint => user) public users;
    
    uint public NFT_cnt = 0; // record the NFT items
    mapping(uint => NFTobj) public NFT_items;
    
    uint public txn_cnt = 0; // record the transaction information
    mapping(uint => NFTtxn) public txn_records;

    
    struct user {
        address user_addr;
        uint assets_cnt;
        mapping(uint => uint) assets;
    }
    
    struct NFTobj {
        uint NFT_id;
        address owner;
        bool on_sale;
        uint txn_id;
        string img_src;
    }
    
    struct NFTtxn {
        uint NFT_id;
        uint price;
        address seller;
        address buyer;
    }
    
    function user_register(address usr_addr) public returns(string) {
        for (uint i=1; i<=user_cnt; i++) { // no need to register
            if (users[i].user_addr == usr_addr) return "fail";
        }
        
        user_cnt++;
        users[user_cnt] = user(usr_addr, 0); // add to user list
        
        return "succeed";
    }
    
    function upload_NFT(string _img_src) public {
        // user_register(msg.sender);
        
        NFT_cnt++;
        NFT_items[NFT_cnt] = NFTobj(NFT_cnt, msg.sender, false, 0, _img_src); // add to NFT list
        
        for (uint i=1; i<=user_cnt; i++) {
            if (users[i].user_addr == msg.sender) {
                users[i].assets_cnt++;
                users[i].assets[users[i].assets_cnt] = NFT_cnt;
                return;
            }
        }
    }
    
    function sale(uint asset_id, uint price) public {
        for (uint i=1; i<=user_cnt; i++) {
            if (users[i].user_addr == msg.sender) {
                require (asset_id <= users[i].assets_cnt && !NFT_items[users[i].assets[asset_id]].on_sale); // check existence and sale state
                NFTobj storage item = NFT_items[users[i].assets[asset_id]];
                
                txn_cnt++;
                txn_records[txn_cnt] = NFTtxn(txn_cnt, price, msg.sender, 0); // add to txn list
                
                item.on_sale = true;
                item.txn_id = txn_cnt;
            }
        }
    }
    
    function purchase(uint NFT_id) public payable {
        require(0 < NFT_id && NFT_id <= NFT_cnt);
        NFTobj storage item = NFT_items[NFT_id]; // find the NFT item
        require(item.on_sale);
        
        NFTtxn storage txn = txn_records[item.txn_id]; // find the transaction
        require(msg.value >= txn.price);
        
        // user_register(msg.sender);
        txn.seller.transfer(msg.value); // do the deal
        item.owner = msg.sender;
        item.on_sale = false;
        txn.buyer = msg.sender;
        
        for (uint i=1; i<=user_cnt; i++) {
            
            if (users[i].user_addr == txn.seller) { // delete from seller
                for (uint j=1; j<=users[i].assets_cnt; j++) {
                    if (users[i].assets[j] == NFT_id) {
                        while (j+1 <= users[i].assets_cnt) {
                            users[i].assets[j] = users[i].assets[j+1];
                        }
                        users[i].assets_cnt--;
                    }
                }
            }
            
            if (users[i].user_addr == msg.sender) { // add to buyer
                users[i].assets[users[i].assets_cnt] = NFT_id;
                users[i].assets_cnt++;
                return;
            }
        }
    }
    
    // used to debug
    function show_asset(uint usr_id, uint asset_id) public view returns(uint NFT_id, address owner, bool on_sale, uint txn_id, string img_src) {
        return (NFT_items[users[usr_id].assets[asset_id]].NFT_id,
                NFT_items[users[usr_id].assets[asset_id]].owner,
                NFT_items[users[usr_id].assets[asset_id]].on_sale,
                NFT_items[users[usr_id].assets[asset_id]].txn_id,
                NFT_items[users[usr_id].assets[asset_id]].img_src);
    }
    
}