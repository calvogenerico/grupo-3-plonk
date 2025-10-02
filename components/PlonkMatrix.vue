<template>
  <div class="matrix-container">
    <div class="matrix-row">  
      <div class="matrix-head">
        Q_l
      </div>
      <div class="matrix-head">
        Q_r
      </div>
      <div class="matrix-head">
        Q_o
      </div>
      <div class="matrix-head">
        Q_p
      </div>
      <div class="matrix-head">
        Q_c
      </div>
      <div v-if="traza" class="matrix-head">
        
      </div>
      <div v-if="traza" class="matrix-head">
        a
      </div>
      <div v-if="traza" class="matrix-head">
        b
      </div>
      <div v-if="traza" class="matrix-head">
        c
      </div>
    </div>
    <div v-for="(row, rowIndex) in matrixData" :key="`row-${rowIndex}`" class="matrix-row">  
      <div v-for="(number, colIndex) in row" :key="`cell-${rowIndex}-${colIndex}`" class="matrix-cell">
        {{ number }}
      </div>

      <div v-if="traza" class="matrix-head">
        
      </div>

      <div v-for="(number, colIndex) in traza[rowIndex]" :key="`cell-${rowIndex}-${colIndex}`" class="matrix-cell">
        {{ number }}
      </div>

      <div v-if="nombres">{{ nombres[rowIndex]  }}</div>
    </div>
  </div>
</template>

<script setup>
import { defineProps } from 'vue';

// Define the component's props
defineProps({
  // The matrixData prop is an array and is required
  matrixData: {
    type: Array,
    required: true,
    // Optional: Validator to ensure the prop is an array of arrays
    validator: (value) => {
      return Array.isArray(value) && value.every(Array.isArray) && value.every(v => v.length === 5);
    }
  },
  traza: {
    type: Array,
    required: false
  },
  nombres: {
    type: Array,
    required: false
  }
});
</script>

<style scoped>
/* Scoped styles apply only to this component */
.matrix-container {
  display: inline-flex; /* Use inline-flex to wrap content tightly */
  flex-direction: column;
  border: 1px solid #333; /* Outer border for the whole matrix */
}

.matrix-row {
  display: flex;
  flex-direction: row;
}

.matrix-cell {
  width: 30px;
  height: 30px;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid #ddd; /* Light border for each cell */
  box-sizing: border-box; /* Ensures padding and border are inside the element's total width and height */
  font-family: monospace;
  font-size: 1rem;
}

.matrix-head {
  width: 30px;
  height: 30px;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid #ddd; /* Light border for each cell */
  box-sizing: border-box; /* Ensures padding and border are inside the element's total width and height */
  font-family: monospace;
  font-size: .8rem;
}
</style>