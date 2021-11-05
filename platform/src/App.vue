<template>
  <div id="wrapper">
    <nav class="navbar is-dark">
      <div class="navbar-brand">
        <router-link to="/" class="navbar-item"><strong>NFTtrading</strong></router-link>

        <a class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbar-menu" @click="showMobileMenu = !showMobileMenu">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div class="navbar-menu" id="navbar-menu" v-bind:class="{'is-active': showMobileMenu }">
        <div class="navbar-start">
          <div class="navbar-item">
            <form method="get" action="/search">
              <div class="field has-addons">
                <div class="control">
                  <input type="text" class="input" placeholder="What are you looking for?" name="query">
                </div>

                <div class="control">
                  <button class="button is-success">
                      <span class="icon">
                      <i class="fas fa-search"></i>
                      </span>
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>

        <div class="navbar-end">
          <router-link to="/Upload" class="navbar-item">Upload</router-link>
          <router-link to="/Sale" class="navbar-item">Sale</router-link>
          <router-link to="/Purchase" class="navbar-item">Purchase</router-link>

          <div class="navbar-item">
            <div class="buttons">
              <template v-if="!account">
                <a @click="get_account" class="button is-light">Log in</a>
              </template>

              <!-- <template v-else>
                <router-link to="/empty" class="button is-light">Log in</router-link>
              </template> -->

              <div v-else> {{ account }} </div>
            </div>
          </div>
        </div>
      </div>
    </nav>

    <!-- <div class="is-loading-bar has-text-centered" v-bind:class="{'is-loading': $store.state.isLoading }">
      <div class="lds-dual-ring"></div>
    </div> -->

    <!-- <router-view/> -->
    <section class="section">
      <router-view/>
    </section>

    <footer class="footer">
      <p class="has-text-centered">Copyright (c) 2021</p>
    </footer>
  </div>
</template>

<script>
import { authenticate, getAccount, user_register } from './api/contract.js'

export default {
  data() {
    return {
      account: 0,
      showMobileMenu: false,
      cart: {
        items: []
      }
    }
  },
  // beforeCreate() {
  // },
  mounted() {
    this.init_account()
    // this.cart = this.$store.state.cart
  },
  methods: {
    async update_global_account() {
      console.log("updating global account")
      this.$store.commit("set_account", this.account)
      await user_register(this.account)
    },
    async init_account() {
        console.log("into init_account")
        await authenticate()
        this.account = await getAccount()
        await this.update_global_account()
        this.$store.commit("add_user", this.account)
    }
    
  },
  computed: {
      
      cartTotalLength() {
          let totalLength = 0

          for (let i = 0; i < this.cart.items.length; i++) {
              totalLength += this.cart.items[i].quantity
          }

          return totalLength
      }
  }
}
</script>

<style lang="scss">
@import '../node_modules/bulma';

.lds-dual-ring {
  display: inline-block;
  width: 80px;
  height: 80px;
}
.lds-dual-ring:after {
  content: " ";
  display: block;
  width: 64px;
  height: 64px;
  margin: 8px;
  border-radius: 50%;
  border: 6px solid #ccc;
  border-color: #ccc transparent #ccc transparent;
  animation: lds-dual-ring 1.2s linear infinite;
}
@keyframes lds-dual-ring {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.is-loading-bar {
  height: 0;
  overflow: hidden;

  -webkit-transition: all 0.3s;
  transition: all 0.3s;

  &.is-loading {
    height: 80px;
  }
}
</style>
