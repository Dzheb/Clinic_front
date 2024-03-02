<template>
  <div class="main">
    <div class="employee__block">
      <h2>Список врачей</h2>

      <table>
        <tr>
          <th class="cell">Ф.И.О.</th>
          <th class="cell">Специализация</th>
          <th class="cell">Категория</th>
          <th class="cell">Дата рождения</th>
          <th class="cell">Операции</th>
        </tr>
        <tr class="content" v-for="doctor in doctors" :key="doctor.id">
          <!-- <td class="employee"> -->
          <td class="cell">
            {{ doctor.fio }}
          </td>
          <td class="cell">
            {{ doctor.speciality }}
          </td>
          <td class="cell_dep">
            {{ doctor.category }}
          </td>
          <td class="cell">
            {{ doctor.birth }}
          </td>
          <td>
            <!-- <div class="update"> -->
            <button
              class="button"
              type="button"
              @click="updateDoctor(doctor.id)"
            >
              Обновить
            </button>
            <!-- </div> -->
            <!-- <div class="delete"> -->
            <button
              class="button"
              type="button"
              @click="deleteDoctor(doctor.id)"
            >
              Удалить
            </button>
            <!-- </div> -->
          </td>
          <!-- </td> -->
        </tr>
      </table>
      <div>
        <button class="button_submit" type="submit" @click="addDoctor()">
          Добавить
        </button>
      </div>
    </div>
    <div class="update_form" id="update" @click.self="closePopup">
      <form class="update_form_content">
        <h2>{{ form_header }}</h2>
        <div>Ф.И.О.: <input type="text" required v-model="doc.fio" /></div>
        <div>
          <label for="speciality">Специализация</label>
          <select
            id="speciality"
            name="speciality"
            v-model="doc.specialityId"
          >
            <option
              v-for="(spec, index) in specialities"
              :key="index"
              :value="spec.id"
            >
              {{ spec.speciality }}
            </option>
          </select>
        </div>
        <div>
          <label for="category">Категория</label>
          <select id="category" name="category" v-model="doc.categoryId">
            <option
              v-for="(cat, index) in categories"
              v-bind:key="index"
              :value="cat.id"
            >
              {{ cat.category }}
            </option>
          </select>
        </div>
        <div>Дата рождения: <input type="date" v-model="doc.birth" /></div>

        <div class="button_submit">
          <button type="submit" @click="sendDoctor()">Отправить</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DoctorList',
  props: {
    registerpassed: {
      type: Boolean,
      // default() {
      //   return false;
      // },
    },
    doctors: {
      type: Array,
      default() {
        return [];
      },
    },
    categories: {
      type: Array,
      default() {
        return [];
      },
    },
    specialities: {
      type: Array,
      default() {
        return [];
      },
    },
  },
  computed: {},
  data() {
    return {
      doc: [],
      form_header: '',
      add: true,
    };
  },

  methods: {
    //   onClickOutside (event, el) {
    //   this.closeModal();
    // },
    deleteDoctor(id) {
         // 
         fetch('http://localhost:9000/appointment/doctor/' + id, {
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
      fetch('http://localhost:9000/doctor/' + id, {
        method: 'DELETE',
      })
        .then((response) => response.ok)
        .then((data) => {
          if (data)
            fetch('http://localhost:9000/doctor')
              .then((response) => response.json())
              .then((docdata) => this.$emit('refreshDoctors', docdata));
        });
    },
    updateDoctor(id) {
      this.add = false;
      this.form_header = 'Обновить информацию';
      const updateForm = document.querySelector('.update_form');
      updateForm.classList.toggle('show');
      fetch('http://localhost:9000/doctor/' + id)
        .then((response) => response.json())
        .then((data) => (this.doc = data));
    },
    addDoctor() {
      this.add = true;
      this.doc.fio = '';
      this.doc.speciality = '';
      this.doc.specialityId = '';
      this.doc.category = '';
      this.doc.categoryId = '';
      this.doc.birth = '';
      const updateForm = document.querySelector('.update_form');
      updateForm.classList.toggle('show');
      this.form_header = 'Форма ввода врача';
    },
    sendDoctor() {
      var requestOptions;
      this.form_header = 'Обновление данных врача';
      const json_object = Object.assign({}, this.doc);
      alert(JSON.stringify(json_object));
      if (this.add) {
        requestOptions = {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(json_object),
        };
        fetch('http://localhost:9000/doctor', requestOptions)
          .then((response) => response.json())
          .then((data) => {
            alert('Информация о враче # ' + data + ' отправлена');
            fetch('http://http://localhost:9000/doctor')
              .then((response) => response.json())
              .then((docdata) => this.$emit('refreshDoctors', docdata));
          });
      } else {
        const updateId = json_object.id;
        delete json_object.id;
        requestOptions = {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(json_object),
        };
        fetch('http://localhost:9000/doctor/' + updateId, requestOptions)
          .then((response) => response.json())
          .then((data) => {
            alert('Информация о враче # ' + data + ' отправлена');
            fetch('http://http://localhost:9000/doctor')
              .then((response) => response.json())
              .then((docdata) => this.$emit('refreshDoctors', docdata));
          });
      }

      const updateForm = document.querySelector('.update_form');
      updateForm.classList.toggle('show');
    },
    closePopup() {
      window.onclick = function (event) {
        const updateForm = document.querySelector('.update_form');
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
/* .content {
  display: flex;
} */
.employee {
  display: flex;
  gap: 16px;
}
.update_form {
  visibility: hidden;
  /* margin-left: 32px; */
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
   background-color: rgb(186, 196, 211);
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
.update_form_content {
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
