<template>
  <div class="main">
    <div class="employee__block">
      <h2>Список записей на приём</h2>

      <table>
        <tr>
          <th class="cell">Врач</th>
          <th class="cell">Пациент</th>
          <th class="cell">Дата</th>
          <th class="cell">Время</th>
          <th class="cell">Операции</th>
        </tr>
        <tr
          class="content"
          v-for="appointment in appointments"
          :key="appointment.id"
        >
          <!-- <td class="employee"> -->
          <td class="cell">
            {{ appointment.doctorName }}
          </td>
          <td class="cell">
            {{ appointment.patientName }}
          </td>
          <td class="cell">
            {{ appointment.appointment_date }}
          </td>
          <td class="cell">
            {{ appointment.appointment_time }}
          </td>
          <td>
            <!-- <div class="update"> -->
            <button
              class="button"
              type="button"
              @click="updateAppointment(appointment.id)"
            >
              Обновить
            </button>
            <!-- </div> -->
            <!-- <div class="delete"> -->
            <button
              class="button"
              type="button"
              @click="deleteAppointment(appointment.id)"
            >
              Удалить
            </button>
          </td>
        </tr>
      </table>
      <div>
        <button class="button_submit" type="submit" @click="addAppointment()">
          Добавить
        </button>
      </div>
    </div>
    <div class="update_form_app" id="update_app" @click.self="closePopup">
      <form class="update_form_content_app">
        <h2>{{ form_header }}</h2>
          <div>
          <label for="doctorName">Врач</label>
          <select
            required
            id="doctorName"
            name="doctorName"
            v-model="app.doctorId"
          >
            <option
              v-for="(doc, index) in doctors"
              :key="index"
              :value="doc.id"
            >
              {{ doc.fio }}
            </option>
          </select>
        </div>
        <div>
          <label for="patientName">Пациент</label>
          <select id="patientName" name="patientName" v-model="app.patientId">
            <option
              v-for="(pat, index) in patients"
              v-bind:key="index"
              :value="pat.id"
            >
              {{ pat.fio }}
            </option>
          </select>
        </div>
        <div>
          Дата приёма: <input type="date" v-model="app.appointment_date" />
        </div>
        <div>
          Время приёма: <input type="time" v-model="app.appointment_time" />
        </div>

        <div class="button_submit">
          <button type="submit" @click="sendAppointment()">Отправить</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'AppointmentsList',
  props: {
    appointments: {
      type: Array,
      default() {
        return [];
      },
    },
    doctors: {
      type: Array,
      default() {
        return [];
      },
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
      app: [],
      form_header: '',
      add: true,
    };
  },

  methods: {
    //   onClickOutside (event, el) {
    //   this.closeModal();
    // },
    deleteAppointment(id) {
      fetch('http://localhost:9000/appointment/' + id, {
        method: 'DELETE',
      })
        .then((response) => response.ok)
        .then((data) => {
          if (data)
            fetch('http://localhost:9000/appointment')
              .then((response) => response.json())
              .then((appdata) => this.$emit('refreshAppointments', appdata));
        });
    },
    updateAppointment(id) {
      this.add = false;
      this.form_header = 'Обновить информацию';
      const updateForm = document.querySelector('.update_form_app');
      updateForm.classList.toggle('show');
      fetch('http://localhost:9000/appointment/' + id)
        .then((response) => response.json())
        .then((data) => (this.app = data));
    },
    addAppointment() {
      this.add = true;
      this.app.doctorName = '';
      this.app.doctorId = '';
      this.app.patientName = '';
      this.app.patientId = ''; 
      this.app.appointment_date = '';
      this.app.appointment_time = '';
      const updateForm = document.querySelector('.update_form_app');
      updateForm.classList.toggle('show');
      this.form_header = 'Форма ввода приёма';
    },
    sendAppointment() {
      var requestOptions;
      this.form_header = 'Обновление данных о приёме';
      const json_object = Object.assign({}, this.app);
      alert(JSON.stringify(json_object));
      if (this.add) {
        requestOptions = {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(json_object),
        };
        fetch('http://localhost:9000/appointment', requestOptions)
          .then((response) => response.json())
          .then((data) => {
            alert('Информация о приёме # ' + data + ' отправлена');
            fetch('http://http://localhost:9000/appointment')
              .then((response) => response.json())
              .then((appdata) => this.$emit('refreshAppointments', appdata));
          });
      } else {
        const updateId = json_object.id;
        delete json_object.id;
        requestOptions = {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(json_object),
        };
        fetch('http://localhost:9000/appointment/' + updateId, requestOptions)
          .then((response) => response.json())
          .then((data) => {
            alert('Информация о приёме # ' + data + ' отправлена');
            fetch('http://http://localhost:9000/appointment')
              .then((response) => response.json())
              .then((appdata) => this.$emit('refreshAppointments', appdata));
          });
      }

      const updateFormApp = document.querySelector('.update_form_app');
      updateFormApp.classList.toggle('show');
    },
    closePopup() {
      window.onclick = function (event) {
        const updateFormApp = document.querySelector('.update_form_app');
        if (event.target == updateFormApp) {
          updateFormApp.classList.toggle('show');
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
/* .content {
  display: flex;
} */
.employee {
  display: flex;
  gap: 16px;
}
.update_form_app {
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
.update_form_content_app {
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
.disappear {
  visibility: hidden;
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
