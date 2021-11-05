<template>
    <div class="page-log-in">
        <div class="columns">
            <div class="column is-4 is-offset-4">
                <h1 class="title">Upload NFT Item</h1>

                <form @submit.prevent="upload">
                    <div class="field">
                        <label>NFT name</label>
                        <div class="control">
                            <input type="text" class="input" v-model="NFTname">
                        </div>
                    </div>

                    <div class="notification is-danger" v-if="errors.length">
                        <p v-for="error in errors" v-bind:key="error">{{ error }}</p>
                    </div>

                    <div class="field">
                        <div class="control">
                            <button class="button is-dark">Upload</button>
                        </div>
                    </div>

                </form>

                <text> {{upload_flag}} </text>
            </div>
        </div>
    </div>
</template>

<script>
import { upload_NFT_item } from '../api/contract'

export default {
    name: 'LogIn',
    data() {
        return {
            upload_flag: '',
            NFTname: '',
            errors: []
        }
    },
    mounted() {
        document.title = 'Upload NFT'
    },
    methods: {
        async upload() {
            console.log("into upload")
            await upload_NFT_item(this.NFTname)
            this.$store.commit("add_user_asset", {account:this.$store.state.account, NFTname:this.NFTname})
            this.update_upload_flag()
            this.$store.commit("get_state")
        },
        update_upload_flag() {
            console.log("into get_aaaaa")
            var print_obj = this.$store.state.assets[this.$store.state.account][0];
            console.log(print_obj)
            this.upload_flag =  this.$store.state.assets[this.$store.state.account][0]
        }
    },
    computed: {
        
    }
}
</script>