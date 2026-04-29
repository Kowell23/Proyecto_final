<template>
  <!--
    App.vue ahora es el punto de entrada puro.
    Todo el layout (navbar, footer, fondo) vive en los layouts.
    RouterView inyecta aquí AuthLayout o MainLayout según la ruta.
  -->
  <RouterView />
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&display=swap');

/* ── Variables globales de diseño ─────────────────────────────── */
:root {
  --color-primary:        #C9B8E8;
  --color-primary-dark:   #7B5EA7;
  --color-primary-light:  #EEE6FF;
  --color-secondary:      #F5B8C8;
  --color-secondary-light:#FFEEF3;
  --color-bg:             #FDF6FF;
  --color-card:           #FFFFFF;
  --color-border:         #E8DEFF;
  --color-text:           #2D1B4E;
  --color-muted:          #8B7BAA;
  --color-accent:         #7B5EA7;
  --color-input:          #F8F4FF;
  --navbar-height:        70px;
}

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  font-family: 'Nunito', sans-serif;
  background: var(--color-bg);
  color: var(--color-text);
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
}

a { color: var(--color-primary-dark); text-decoration: none; }

::-webkit-scrollbar { width: 8px; }
::-webkit-scrollbar-track { background: var(--color-primary-light); }
::-webkit-scrollbar-thumb { background: var(--color-primary); border-radius: 99px; }
</style>