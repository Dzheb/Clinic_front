<template>
  <div class="main__frame">
    <h2>Ипотечный калькулятор</h2>
    <div class="input__block">
      <label for="loanAmount">Сумма кредита</label>
      <input
        class="input_item"
        id="loanAmount"
        v-model="loanAmount"
        type="number"
      />
      <label for="interest">Процент (год)</label>
      <input
        class="input_item"
        id="interest"
        v-model="interest"
        type="number"
      />
      <label for="loanTerm">Срок (лет)</label>
      <input
        class="input_item"
        id="loanTerm"
        v-model="loanTerm"
        type="number"
      />
    </div>
    <div class="result">
      <div v-if="monthlyPayment != 'NaN'">
        Ежемесячный платёж: {{ monthlyPayment | formatRub }}
      </div>
      <div
        v-if="
          this.loanTerm != '' && this.interest != '' && this.loanAmount != ''
        "
      >
        Общая сумма кредита: {{ totalLoan | formatRub }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'LoanCalc',

  data() {
    return {
      loanAmount: '',
      interest: '',
      loanTerm: '',
    };
  },
  computed: {
    monthlyPayment: function () {
      const principal = parseFloat(this.loanAmount);
      const interestRate = parseFloat(this.interest) / 100 / 12;
      const loanTermMonths = parseFloat(this.loanTerm) * 12;
      const numerator =
        principal * interestRate * Math.pow(1 + interestRate, loanTermMonths);
      const denominator = Math.pow(1 + interestRate, loanTermMonths) - 1;
      let result;

      result = (numerator / denominator).toFixed(2);
      return result;
    },
    totalLoan: function () {
      return this.monthlyPayment * 12 * parseFloat(this.loanTerm).toFixed(2);
    },
  },
  filters: {
    formatRub: function (value) {
      const formatter = new Intl.NumberFormat('ru-RU', {
        style: 'currency',
        currency: 'RUB',
      });
      return formatter.format(value);
    },
  },
  methods: {},
};
</script>

<style lang="css" scoped>
.main__frame {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.input__block {
  margin: 36px;
  width: 75vw;
  display: flex;
  flex-direction: column;
  justify-content: baseline;
  gap: 6px;
  align-items: center;
  font-size: 20px;
}
.input_item {
  width: 80px;
}
</style>
