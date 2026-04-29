<template>
  <div class="modal-overlay" @click.self="$emit('close')">
    <div class="modal-card">
      <span class="modal-icon">🔐</span>
      <h2>¡Necesitas una cuenta!</h2>
      <p>Para guardar recetas favoritas debes iniciar sesión o registrarte. Es gratis 🎉</p>
      <div class="modal-actions">
        <button @click="$router.push({ name: 'Login' })"    class="btn-primary">Iniciar sesión</button>
        <button @click="$router.push({ name: 'Register' })" class="btn-secondary">Registrarse</button>
      </div>
      <button @click="$emit('close')" class="btn-close">Seguir explorando</button>
    </div>
  </div>
</template>

<script setup>
defineEmits(['close'])
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(45, 27, 78, .45);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 200;
  padding: 1rem;
}
.modal-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  max-width: 380px;
  width: 100%;
  text-align: center;
  box-shadow: 0 20px 60px rgba(0, 0, 0, .2);
}
.modal-icon { font-size: 2.5rem; display: block; margin-bottom: .75rem; }
.modal-card h2 { font-size: 1.3rem; font-weight: 900; color: var(--color-text); margin-bottom: .5rem; }
.modal-card p  { font-size: .9rem; color: var(--color-muted); line-height: 1.5; margin-bottom: 1.5rem; }
.modal-actions { display: flex; gap: .75rem; margin-bottom: .75rem; }
.btn-primary {
  flex: 1; padding: .75rem;
  background: var(--color-primary-dark); color: white;
  border: none; border-radius: 10px;
  font-family: 'Nunito', sans-serif; font-size: .9rem; font-weight: 800;
  cursor: pointer; transition: opacity .2s;
}
.btn-primary:hover { opacity: .88; }
.btn-secondary {
  flex: 1; padding: .75rem;
  background: var(--color-primary-light); color: var(--color-primary-dark);
  border: none; border-radius: 10px;
  font-family: 'Nunito', sans-serif; font-size: .9rem; font-weight: 800;
  cursor: pointer; transition: opacity .2s;
}
.btn-secondary:hover { opacity: .8; }
.btn-close {
  width: 100%; background: none; border: none;
  color: var(--color-muted); font-family: 'Nunito', sans-serif;
  font-size: .85rem; font-weight: 700; cursor: pointer; padding: .4rem;
}
.btn-close:hover { color: var(--color-text); }
</style>