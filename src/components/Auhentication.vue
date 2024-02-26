<template>
  <p v-if="ok">Registration passed!</p>
  <div v-else class="div__item">
    <form action="#">
      <label class="input_label">Имя : </label>
      <input class="input__item" v-model="loginEntered" type="text" />
      <label class="input_label">Пароль : </label>
      <input class="input__item" v-model="passEntered" type="number" />
      <button class="btn__item" @click="register">Войти</button>
    </form>
  </div>
</template>

<script>
export default {
  name: 'AppAuhentication',
  props: ['login', 'pass'],
  data() {
    return {
      loginEntered: '',
      passEntered: '',
      ok: false,
    };
  },

  methods: {
    register() {
      if (this.loginEntered === this.login && this.passEntered === this.pass) {
        this.ok = true;
        this.$emit('passAuth', this.ok);
      }
    },
  },
};
</script>

<style lang="css" scoped>
.input_label {
  margin: 16px;
}
.div__item {
  background-color: rgb(212, 215, 223);
  color: blue;
  margin: 16px;
  padding: 8px;
  gap: 8px;
  font-size: 24px;
  font-weight: 600;
}
</style>
