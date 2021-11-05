<template>
    <div class="page-cart">

        <div class="column is-4 is-offset-4">
            <h1 class="title"> Sell NFT Item </h1>

            <form @submit.prevent="submitForm">
                <div class="field">
                    <label> Which NFT do you want to sell? (please input id) </label>
                    <div class="control">
                        <input type="text" class="input" v-model="NFT_id_to_sell">
                    </div>
                </div>
                <div class="field">
                    <label> Set the price </label>
                    <div class="control">
                        <input type="text" class="input" v-model="NFT_price">
                    </div>
                </div>

                <!-- <div class="notification is-danger" v-if="errors.length">
                    <p v-for="error in errors" v-bind:key="error">{{ error }}</p>
                </div> -->

                <div class="field">
                    <div class="control">
                        <button class="button is-dark"> Sell </button>
                    </div>
                </div>

            </form>
        </div>

        <div class="columns is-multiline">
            <div class="column is-12">
                <h1 class="title">Assets</h1>
                <button @click="update_items" class="button is-dark"> get_assets </button>
            </div>

            <div class="column is-12 box">
                
                <div v-if="this.items.length">
                    
                        <!-- <img src="../assets/fig1.png"> -->
                        <!-- <div v-for="item in list": ref="NFT_item_ref"> -->
                            <!-- <img v-for="item in list": src="NFT_item_ref"> -->
                        <!-- </div> -->
                    <div v-for="item in items" :key="item.id">
                        <!-- <div class='column is-2'> -->
                            <text>{{item.id+1}}</text>
                            <figure class="image mb-4 is-128x128">
                                <!-- <img :src="require('' + item.message + '')"> -->
                                <img :src="item.message">
                                <!-- <img src="../assets/fig1.png"> -->
                            </figure>
                        <!-- </div> -->
                    </div>

                    
                </div>
                <p v-else>You don't have any NFT assets...</p>
            </div>
        </div>
    </div>
</template>

<script>
import { sale } from '../api/contract'

export default {
    data() {
        return {
            items: [],
            NFT_id_to_sell: '',
            NFT_price: ''
        }
    },
    mounted() {
    },
    methods: {
        update_items() {
            var lst = this.$store.state.assets[this.$store.state.account]
            this.items = []
            // for (let i=0; i<lst.length; i++) {
            //     this.items.push({id: i, message:"../assets/" + lst[i] + ".png"})
            // }
             for (let i=0; i<lst.length; i++) {
                this.items.push({id: i, message:require("../assets/" + lst[i] + ".png")})
            }
            // this.items = this.$store.commit("get_assets")
            // console.log("items in sale")
            console.log(this.items)
        },
        removeFromCart(item) {
            this.cart.items = this.cart.items.filter(i => i.product.id !== item.product.id)
        },
        async submitForm() {
            await sale(this.NFT_id_to_sell, this.NFT_price)
        }
    },
    computed: {
    }
}
</script>