<template>
  <div class="calc">
    <h2 class="calc__head">Обычный калькулятор</h2>
    <input class="input__col" type="text" v-model="result" />
    <button @click="addBtn(num)" v-for="num in nums" :key="num.id">{{ num }}</button>
    <button @click="addBtn(tab)" v-for="tab in tabs" :key="tab.id">{{ tab }}</button>
    <button @click="calcResult()">=</button>
    <button class="reset" @click="reset">reset</button>
  </div>
</template>

<script>
export default {
  name: 'CalcComponent',

  data() {
    return {
      result:'',
      nums: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
      tabs: ['-', '+', '/', '*'],
    };
  },

  methods: {
    addBtn(num) {
      this.result = this.result.toString();
      this.result += num;
    },
    calcResult() {
      this.result = eval(this.result);
    },
    reset() {
      this.result = '';
    }
  },
};
</script>

<style lang="css" scoped>
.calc {
  display: grid;
  grid-template-columns: repeat(3, 100px);
  justify-content: center;
  padding-top: 48px;
  padding-bottom: 48px;
}
.calc__head {
  grid-column: 1 / -1;
}
.input__col {
grid-column: 1 / -1;
text-align: right;
}
.reset {
grid-column: 1 / -1;

}
</style>
