<template>
    <div class="page-log-in">
        <div class="columns">
            <div class="column is-4 is-offset-4">
                <h1 class="title"> Purchase NFT Item </h1>

                <form @submit.prevent="submitForm">
                    <div class="field">
                        <label> Which NFT do you want to buy? (please input id) </label>
                        <div class="control">
                            <input type="text" class="input" v-model="Purchase_id">
                        </div>
                    </div>

                    <div class="field">
                        <label> How much can you afford?</label>
                        <div class="control">
                            <input type="text" class="input" v-model="afford_price">
                        </div>
                    </div>

                    <div class="field">
                        <div class="control">
                            <button class="button is-dark"> Purchase </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</template>

<script>
import { purchase } from '../api/contract'

export default {
    data() {
        return {
            Purchase_id: '',
            afford_price: '',
        }
    },
    mounted() {
        document.title = 'Purchase'
    },
    methods: {
        async submitForm() {
            await purchase(this.Purchase_id, this.afford_price)
        }
    }
}
</script>