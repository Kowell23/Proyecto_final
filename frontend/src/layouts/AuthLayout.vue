<template>
  <!-- Layout limpio: solo el fondo y la vista hija centrada.
       Sin navbar ni footer — estas páginas no los necesitan. -->
  <div class="auth-layout">
    <RouterView />
  </div>
</template>

<style scoped>
.auth-layout {
  min-height: 100vh;
  background: var(--color-bg);
}
</style>