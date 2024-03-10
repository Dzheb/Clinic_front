<template>
  <div class="main">
    <div class="employee__block">
      <h2>Список пациентов</h2>

      <table class="table_patient">
        <tr>
          <th class="cell">Фамилия</th>
          <th class="cell">Имя</th>
          <th class="cell">Отчество</th>
          <th class="cell">Операции</th>
        </tr>
        <tr
          class="content"
          v-for="(patient, index) in patients"
          :key="patient.id"
        >
          <td class="cell">
            {{ patient.family }}
          </td>
          <td class="cell">
            {{ patient.name }}
          </td>
          <td class="cell_dep">
            {{ patient.middle_name }}
          </td>
          <td>
            <button class="button" type="button" @click="updatePatient(index)">
              Обновить
            </button>

            <button
              class="button"
              type="button"
              @click="deletePatient(patient.id)"
            >
              Удалить
            </button>
          </td>
        </tr>
      </table>
      <div>
        <button class="button_submit" type="submit" @click="addPatient()">
          Добавить
        </button>
      </div>
    </div>
    <div
      class="update_form_patient"
      id="update_patient"
      @click.self="closePopup"
    >
      <form class="update_form_content_patient">
        <h2>{{ form_header }}</h2>
        <div>Фамилия: <input type="text" required v-model="pat.family" /></div>
        <div>Имя: <input type="text" v-model="pat.name" /></div>
        <div>Отчество: <input type="text" v-model="pat.middle_name" /></div>
        <div class="button_submit">
          <button type="submit" @click="sendPatient()">Отправить</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PatientList',
  props: {
    registerpassed: {
      type: Boolean,
      // default() {
      //   return false;
      // },
    },
    patients: {
      type: Array,
      default() {
        return [];
      },
    },
  },
  computed: {},
  data() {
    return {
      pat: [],
      form_header: '',
      add: true,
    };
  },
  methods: {
    deletePatient(id) {
      //
      fetch('http://localhost:9000/appointment/patient/' + id, {
        method: 'DELETE',
      })
        .then((response) => response.ok)
        .then((data) => {
          if (data)
            fetch('http://localhost:9000/appointment')
              .then((response) => response.json())
              .then((appdata) => this.$emit('refreshAppointments', appdata));
        });
      //
      fetch('http://localhost:9000/patient/' + id, {
        method: 'DELETE',
      })
        .then((response) => response.ok)
        .then((data) => {
          if (data)
            fetch('http://localhost:9000/patient')
              .then((response) => response.json())
              .then((patdata) => this.$emit('refreshPatients', patdata));
        });
    },
    updatePatient(id) {
      this.add = false;
      this.form_header = 'Обновить информацию';
      const updateForm = document.querySelector('.update_form_patient');
      updateForm.classList.toggle('show');
      this.pat = this.patients[id];
    },
    addPatient() {
      this.add = true;
      this.pat.family = '';
      this.pat.name = '';
      this.pat.middle_name = '';
      const updateForm = document.querySelector('.update_form_patient');
      updateForm.classList.toggle('show');
      this.form_header = 'Форма ввода пациента';
    },
    sendPatient() {
      var requestOptions;
      this.form_header = 'Обновление данных пациента';
      const json_object = Object.assign({}, this.pat);
      alert(JSON.stringify(json_object));
      if (this.add) {
        requestOptions = {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(json_object),
        };
        fetch('http://localhost:9000/patient', requestOptions)
          .then((response) => response.json())
          .then((data) => {
            alert('Информация о пациенте # ' + data + ' отправлена');
            fetch('http://http://localhost:9000/patient')
              .then((response) => response.json())
              .then((patdata) => this.$emit('refreshPatents', patdata));
          });
      } else {
        const updateId = json_object.id;
        delete json_object.id;
        requestOptions = {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(json_object),
        };
        fetch('http://localhost:9000/patient/' + updateId, requestOptions)
          .then((response) => response.json())
          .then((data) => {
            alert('Информация о пациенте # ' + data + ' отправлена');
            fetch('http://http://localhost:9000/patient')
              .then((response) => response.json())
              .then((patdata) => this.$emit('refreshPatients', patdata));
          });
      }

      const updateForm = document.querySelector('.update_form_patient');
      updateForm.classList.toggle('show');
    },
    closePopup() {
      window.onclick = function (event) {
        const updateForm = document.querySelector('.update_form_patient');
        if (event.target == updateForm) {
          updateForm.classList.toggle('show');
        }
      };
    },
  },
};
</script>

<style lang="css" scoped>
.main {
  display: flex;
  justify-content: center;
}
.employee__block {
  display: flex;
  flex-direction: column;
  align-items: left;
  gap: 16px;
  font-family: Jost;
  font-size: 22px;
  font-weight: 400;
  line-height: 33px;
  letter-spacing: 0.01em;
  padding: 8px 16px;
  background-color: rgb(186, 196, 211);
  border-radius: 16px;
  box-shadow: 0px 10px 15px 0px rgba(25, 45, 120, 0.2);
}
.table_patient {
  overflow-y: scroll; /* make the table scrollable if height is more than 200 px  */
  height: 200px; /* gives an initial height of 200px to the table */
}
thead th {
  position: sticky; /* make the table heads sticky */
  top: 0px; /* table head will be placed from the top of the table and sticks to it */
}
table {
  border-collapse: collapse; /* make the table borders collapse to each other */
  width: 100%;
}
th,
td {
  padding: 8px 16px;
  border: 1px solid #ccc;
}
th {
  background: #eee;
}
/* .content {
  display: flex;
} */
/* .employee {
  display: flex;
  gap: 16px;
} */
.update_form_patient {
  visibility: hidden;
  /* margin-left: 32px; */
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  /* box-shadow: 0px 10px 15px 0px rgba(25, 45, 120, 0.2); */
  background-color: rgb(186, 196, 211);
  /* border-radius: 16px;  */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0, 0, 0); /* Fallback color */
  background-color: rgba(0, 0, 0, 0.4);
}
.update_form_content_patient {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  gap: 24px;
  padding: 16px;
  background-color: rgb(186, 196, 211);
  box-shadow: 0px 10px 15px 0px rgba(25, 45, 120, 0.2);
  border-radius: 16px;
}
.button_submit {
  text-align: end;
  box-shadow: 0px 10px 15px 0px rgba(25, 45, 120, 0.2);
  border-radius: 8px;
  margin: 0 8px;
}
.button {
  text-align: end;
  box-shadow: 0px 10px 15px 0px rgba(25, 45, 120, 0.2);
  border-radius: 4px;
  margin: 0 8px;
}
.button:hover {
  background-color: rgb(184, 187, 148);
}
.show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}
.cell {
  text-align: left;
}
.cell_dep {
  text-align: center;
}
.content {
  gap: 8px;
}
</style>
