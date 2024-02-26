<template>
  <div class="calc__fun">
    <h2>Функциональный калькулятор</h2>
    <input type="text" v-model="operand1">
    <input type="text"  v-model="operand2">
    {{ result }}
    <div v-show="error">
      {{ error }}
    </div>
    <div>
      <button @click="calcAll(operation)" v-for="operation in operations" :key="operation.id">{{ operation }}</button>
    </div>
    <div>
      <template v-if="result < 0">Получилось отрицательное число</template>
      <template v-if="result > 0 && result < 100">Получилось число от 0 до 100</template>
      <template v-if="result > 100">Получилось число больше 100</template>
    </div>
    <div>
      Число Фибоначчи для первого поля ввода: {{ fib1 }}<br>
      Число Фибоначчи для второго поля ввода: {{ fib2 }}<br>
    </div>
    <div>
      <h3>История операций</h3>
      <p v-for="log in logs" :key="log.id">{{ log }}</p>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
export default {
  name: 'CalcFunc',

  data() {
    return {
      operand1: '',
      operand2: '',
      result: '',
      operations: ['+','-','*','/'],
      error:'',
      logs: {}
    };
  },

  methods: {
    add() {
      this.result = Number(this.operand1) + Number(this.operand2);
    },
    min() {
      this.result = Number(this.operand1) - Number(this.operand2);
    },
    mul() {
      this.result = Number(this.operand1) * Number(this.operand2);
    },
    div() {
      const{operand1,operand2} = this;
      if (Number(operand2) === 0) {
        this.error = "Ошибка: деление на 0!";
      } else {
        this.result = Number(operand1) / Number(operand2)
      }
    },
    fib(n) {
      return n <= 1 ? n : this.fib(n-1) + this.fib(n - 2);
    },
    calcAll (operation = '+') {
      this.error = '';
      switch (operation) {
        case '+':
          this.add();
          break;
        case '-':
          this.min();
          break;
        case '*':
          this.mul();
          break;
        case '/':
          this.div();
          break; 
      }
      const key = Date.now();
      const value = this.logs[Date.now()] = `${this.operand1} ${operation} ${this.operand2} = ${this.result}`;
      Vue.set(this.logs,key,value);
    },
  },
  computed: {
    fib1() {
      return this.fib(this.operand1);
    },
    fib2() {
      return this.fib(this.operand2);
    },
  }
};
</script>

<style lang="css" scoped>
.calc__fun {
  margin:45px 0;
}
</style>