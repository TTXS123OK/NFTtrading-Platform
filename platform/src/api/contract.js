import Web3 from 'web3'
import NFTtrading from './NFTtrading.json'

const web3 = new Web3(window.ethereum);
const contract = new web3.eth.Contract(NFTtrading.abi, '0xD4dce093688F3174F5dE7E1A0070E6e49fee6b79');

async function authenticate() {
    await window.ethereum.enable();
}

async function getAccount() {
    return (await web3.eth.getAccounts())[0];
}

async function user_register(user_addr) {
    console.log("into user_register")
    // res = await contract.methods.user_register(user_addr).call();
    // console.log("register succeed")
    // return res;
    return await contract.methods.user_register(user_addr).send({
        from: await getAccount(),
        gas: 1000000
    })
}

// async function contribute(id:number, value:number) {
//     return await contract.methods.contribute(id).send({from: await getAccount(), value: Web3.utils.toWei(value.toString(10), 'ether')});
// }

async function upload_NFT_item(src) {
    // console.log("into upload_NFT_item")
    // account = await getAccount()
    // console.log("already get account")
    return await contract.methods.upload_NFT(src).send({
        from: await getAccount(),
        gas: 1000000
    });
}

async function sale(asset_id, price) {
    return await contract.methods.sale(asset_id, Web3.utils.toWei(price.toString(10), 'ether')).send({
        from: await getAccount(),
        gas: 1000000
    })
}

async function purchase(asset_id, afford) {
    return await contract.methods.purchase(asset_id).send({
        from: await getAccount(),
        value: Web3.utils.toWei(afford.toString(10), 'ether'),
        gas: 1000000
    })
}

export {
    getAccount,
    authenticate,
    user_register,
    upload_NFT_item,
    sale,
    purchase
}