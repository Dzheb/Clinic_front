<template>
  <div class="app_frame" id="app">
    <div><h1 class="main_header">Медицинский центр "Айболит"</h1></div>
    <div class="main_frame">
      <!-- <img alt="Vue logo" src="./assets/logo.png"> -->
      <!-- <HelloWorld msg="Calculator"/> -->
      <!-- <CalcComponent/> -->
      <!-- <CalcFunc/> -->
      <!-- <h2>Ещё один калькулятор</h2>
    <CalcComponent/> -->
      <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
      <!-- <AppAuhentication login="hello" pass="123456" @passAuth="passAuth" /> -->
      <!-- <div class="calc">
     <LoanCalc/>
   </div> -->
      <!-- <UsersList>
      <UserComp/>
    </UsersList> -->
      <!-- <ProductDetails :products="prods"/> -->
      <div class="docs">
        <DoctorList
          :doctors="docs"
          :specialities="specs"
          :categories="cats"
          :registerpassed="registered"
          @refreshDoctors="refreshDoctors"
        />
      </div>
      <div class="pats">
        <PatientList
          :patients="pats"
          :registerpassed="registered"
          @refreshPatients="refreshPatients"
        />
      </div>
    </div>
  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
// import CalcComponent from './components/CalcComponent.vue'
// import CalcFunc from './components/CalcFunc.vue'

// import AppAuhentication from './components/Auhentication.vue'
// import UserComp from './components/UserComp.vue'
// import UsersList from './components/UsersList.vue'
// import LoanCalc from './components/LoanCalc.vue';
// import ProductDetails from './components/ProductDetails.vue'
import DoctorList from './components/DoctorList.vue';
import PatientList from './components/PatientList.vue';

export default {
  name: 'App',
  components: {
    // HelloWorld,
    // CalcComponent,
    // CalcFunc
    // AppAuhentication,
    // UserComp,
    // UsersList
    //  LoanCalc,
    // ProductDetails
    DoctorList,
    PatientList,
  },
  data() {
    return {
      //  prods:[]
      docs: [],
      pats: [],
      cats: [],
      specs: [],
      registered: true, // без идентификации
    };
  },
  methods: {
    fetchDocs() {
      fetch('http://localhost:9000/doctor')
        .then((response) => response.json())
        .then((data) => (this.docs = data));
    },
    fetchPats() {
      fetch('http://localhost:9000/patient')
        .then((response) => response.json())
        .then((data) => (this.pats = data));
    },
    fetchSpecs() {
      fetch('http://localhost:9000/speciality')
        .then((response) => response.json())
        .then((data) => (this.specs = data));
    },
    fetchCats() {
      fetch('http://localhost:9000/category')
        .then((response) => response.json())
        .then((data) => (this.cats = data));
    },
    refreshDoctors(docdata) {
      this.docs = docdata;
    },
    refreshPatients(patdata) {
      this.pats = patdata;
    },

    passAuth(ok) {
      if (ok) {
        this.registered = true;
      }
    },
  },
  computed: {},
  created() {
    // this.prods =  this.fetchData();
    this.docs = this.fetchDocs();
    this.pats = this.fetchPats();
    this.specs = this.fetchSpecs();
    this.cats = this.fetchCats();
  },
};
</script>

<style>
.main_frame {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: baseline;
  gap: 16px;
}
.app_frame {
  display: flex;
  flex-direction:column;
  align-items: center;
}
</style>
