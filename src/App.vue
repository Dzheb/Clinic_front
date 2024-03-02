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
      <!-- <ProductDetails :products="prods"/> 
      -->

      <div class="apps">
        <AppointmentsList
          :appointments="apps"
          :doctors="docs"
          :patients="pats"
          @refreshAppointments="refreshAppointments"
        />
      </div>

    <div class="main_frame_top">
      <div class="docs">
        <DoctorList
          :doctors="docs"
          :specialities="specs"
          :categories="cats"
          :appointments="apps"
          :registerpassed="registered"
          @refreshDoctors="refreshDoctors"
          @refreshAppointments="refreshAppointments"
        />
      </div>
      <div class="pats">
        <PatientList
          :patients="pats"
          :appointments="apps"
          :registerpassed="registered"
          @refreshPatients="refreshPatients"
          @refreshAppointments="refreshAppointments"
        />
      </div>
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
import AppointmentsList from './components/AppointmentsList.vue';

export default {
  name: 'App',
  components: {
    // HelloWorld,
    // CalcComponent,
    // CalcFunc,
    // AppAuhentication,
    // UserComp,
    // UsersList
    //  LoanCalc,
    // ProductDetails
    DoctorList,
    PatientList,
    AppointmentsList,
  },
  data() {
    return {
      //  prods:[]
      docs: [],
      pats: [],
      cats: [],
      specs: [],
      apps: [],
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
    fetchApps() {
      fetch('http://localhost:9000/appointment')
        .then((response) => response.json())
        .then((data) => (this.apps = data));
    },
    refreshDoctors(docdata) {
      this.docs = docdata;
    },
    refreshPatients(patdata) {
      this.pats = patdata;
    },
    refreshAppointments(appdata) {
      this.apps = appdata;
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
    this.apps = this.fetchApps();
  },
};
</script>

<style>
.main_frame {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 16px;
}
.main_frame_top {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: baseline;
  gap: 10vh;
}
.app_frame {
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
