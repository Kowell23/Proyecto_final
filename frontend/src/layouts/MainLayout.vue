<template>
  <!-- Layout principal: Navbar arriba, contenido en el medio,
       Footer pegado abajo siempre gracias a flex-column + flex:1. -->
  <div class="main-layout">
    <Navbar />
    <main class="main-content">
      <RouterView />
    </main>
    <Footer />
  </div>
</template>

<script setup>
import Navbar from '../components/navbar.vue'
import Footer from '../components/Footer.vue'
</script>

<style scoped>
.main-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}
.main-content {
  flex: 1;                        /* empuja el footer siempre al fondo */
  padding-top: var(--navbar-height);
}
</style>