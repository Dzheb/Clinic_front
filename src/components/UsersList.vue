<!-- Создайте компонент "Список пользователей" (UserList), который будет отображать список пользователей из переданного массива. Каждый пользователь должен быть представлен в виде отдельного компонента "Пользователь" (User), принимающего пропсы с данными о пользователе (например, имя, фамилия и электронная почта). -->
<template>
  <div >
    <div class="user__comp" v-for="user in users" :key="user.id">
      {{ user.firstName }} {{ user.lastName }} {{ user.email }}
    </div>

  </div>
</template>

<script>
export default {
  name: 'UsersList',
  props: ['firstName', 'lastName','email'],
  data() {
        return {
            users: [
                { id: 1, firstName: 'Иван', lastName: 'Иванов', email: 'ivan@example.com' },
                { id: 2, firstName: 'Петр', lastName: 'Петров', email: 'petr@example.com' },
                { id: 3, firstName: 'Анна', lastName: 'Сидорова', email: 'anna@example.com' }
            ]
        };
 
  },

  methods: {
    
  },
};
</script>

<style lang="css" scoped>
.user__comp {
  display: flex;
  flex-direction: column;
  margin: 28px;
  font-size: 36px;
  text-align: left;
  background-color: rgb(178, 163, 79);
  border-radius: 16px;
  box-shadow: 3px 5px;
}
</style>