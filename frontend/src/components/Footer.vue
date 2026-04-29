<template>
  <footer class="footer">
    <div class="footer-content">
      <span class="footer-logo">🍳 Recetas de Cocina</span>
      <span class="footer-sep">·</span>
      <span class="footer-author">Hecho por <strong>Nicolás</strong></span>
      <span class="footer-sep">·</span>
      <span class="footer-year">© {{ year }}</span>
    </div>
  </footer>
</template>

<script setup>
const year = new Date().getFullYear()
</script>

<style scoped>
.footer {
  background: white;
  border-top: 1.5px solid var(--color-border);
  padding: 1.25rem 2rem;
}
.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: .75rem;
  flex-wrap: wrap;
  font-size: .88rem;
  color: var(--color-muted);
  font-weight: 600;
}
.footer-logo { color: var(--color-primary-dark); font-weight: 800; }
.footer-sep  { color: var(--color-border); }
</style>
