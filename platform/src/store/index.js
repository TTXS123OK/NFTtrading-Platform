import { createStore } from 'vuex'

export default createStore({
  state: {
    account:0,
    assets: {},
  },
  mutations: {
    get_state(state) {
      var res = state
      console.log(res)
    },

    set_account(state, _account) {
      console.log("setting account: %s", _account)
      state.account = _account
      console.log("after setting account: %s", state.account)
    },
    
    // get_assets(state) {
    //   let res = []
    //   console.log(state);
    //   if (JSON.stringify(state.assets) == '{}') return
    //   let len = state.assets[state.account].length
    //   console.log(len);
    //   for (let i=0; i<len; i++) {
    //     console.log("loop: i=%d", i);
    //     res.push({id:i, message:"../assets/" + state.assets[state.account][i] + ".png"})
    //     console.log(res.length)
    //   }
    //   return res
    // },

    add_user(state, account) {
      state.assets[account] = []
    },

    add_user_asset(state, payload) {
      console.log("adding user_asset account: %s, NFTname: %s", payload.account, payload.NFTname)
      state.assets[payload.account].push(payload.NFTname)
    }
  },
  actions: {
  },
  modules: {
  }
})
