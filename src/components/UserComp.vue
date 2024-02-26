<template>
  <div>
      <h2>{{ user.name }}</h2>
      <h1>{{ user.surName }}</h1>
      <p>{{ user.email }}</p>
      <br>
  </div>
</template>
<script>
export default {
  name: 'UserComp',
props: {
  user: Object,
},
  
}
</script>
<style lang="css" scoped>

</style>