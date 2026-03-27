<template>
  <RouterView />
</template>

<style>
:root {
  --color-accent:  #e67e22;
  --color-bg:      #f4f4f5;
  --color-card:    #ffffff;
  --color-border:  #e2e2e6;
  --color-input:   #f9f9fb;
  --color-text:    #18181b;
  --color-muted:   #71717a;
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-bg:     #111113;
    --color-card:   #1c1c1f;
    --color-border: #2e2e33;
    --color-input:  #28282d;
    --color-text:   #f4f4f5;
    --color-muted:  #a1a1aa;
  }
}

*, *::before, *::after { box-sizing: border-box; }

body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  background: var(--color-bg);
  color: var(--color-text);
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
}

a { color: var(--color-accent); }
</style>
