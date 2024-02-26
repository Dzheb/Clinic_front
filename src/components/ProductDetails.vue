<!-- Вы разрабатываете приложение для интернет-магазина и у вас есть компонент Vue под названием "ProductDetails". Компонент отображает детали о конкретном продукте, включая его название, цену и статус доступности.

Внутри компонента "ProductDetails" создайте свойство "product" с объектом, представляющим информацию о продукте. Объект должен иметь свойства "name" (название продукта), "price" (цена продукта) и "available" (флаг, указывающий на доступность продукта).
Используя вычисляемое свойство, назовите его "formattedPrice", которое будет возвращать форматированную цену продукта со знаком валюты. Например, если цена равна 99.99, вычисляемое свойство должно вернуть строку "$99.99".
В компоненте "ProductDetails" отобразите название продукта, его форматированную цену и статус доступности.
Если продукт доступен, отобразите текст "Available", в противном случае - "Out of stock". -->
<template>
  <div class="main">
    <div class="product__block">
      <h2>Products</h2>
      <div class="content" v-for="product in products" :key="product.id">
        <div class="product">
          <div class="name">
            {{ product.name }}
          </div>
          <div class="price">Price : {{ formattedPrice(product.price) }}</div>
          <div v-if="product.available" class="available">Available</div>
          <div v-else class="available">Out of stock</div>
        </div>
      </div>
    </div>
   
  </div>
</template>

<script>
export default {
  name: 'ProductDetails',
  props: {
    products: {
      type: Array,
      default() {
        return [];
      },
    },
  },
  computed: {
    formattedPrice() {
      return (data) => `$${data}`;
    },
  },
  data() {
    return {
      formatPrice: '',
    };
  },

  methods: {},
};
</script>

<style lang="css" scoped>
.main {
  display: flex;
  justify-content: center;
}
.product__block {
  display: flex;
  flex-direction: column;
  align-items: left;
  gap: 16px;
  font-family: Jost;
  font-size: 22px;
  font-weight: 400;
  line-height: 33px;
  letter-spacing: 0.01em;
}
.content {
  display: flex;
}
.product {
  display: flex;
  gap: 16px;
}
</style>
