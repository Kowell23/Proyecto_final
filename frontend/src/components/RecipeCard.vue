<template>
  <div
    class="recipe-card"
    :style="{ '--card-color': color }"
    @click="$router.push(`/recipes/${recipe.id}`)"
  >
    <div class="card-top">
      <div class="card-emoji">{{ categoryEmoji(recipe.category) }}</div>
      <!-- El botón solo emite el evento — el padre decide qué hacer -->
      <button class="btn-fav" @click.stop="$emit('toggle-favorite', recipe)">
        {{ recipe.isFavorite ? '❤️' : '🤍' }}
      </button>
    </div>

    <img
      v-if="recipe.image_url"
      :src="recipe.image_url"
      :alt="recipe.title"
      class="card-img"
    />

    <div class="card-body">
      <span class="card-category">{{ recipe.category || 'Receta' }}</span>
      <h3 class="card-title">{{ recipe.title }}</h3>
      <p class="card-desc">{{ recipe.description || 'Una deliciosa receta.' }}</p>
      <div class="card-footer">
        <span class="card-author">👩‍🍳 {{ recipe.author }}</span>
        <span class="card-arrow">→</span>
      </div>
    </div>
  </div>
</template>

<script setup>
// ── Props: datos que recibe del componente padre ──────────────────
const props = defineProps({
  recipe: {
    type: Object,
    required: true,
  },
  color: {
    type: String,
    default: '#EEE6FF',
  },
})

// ── Emits: eventos que avisa al padre ─────────────────────────────
defineEmits(['toggle-favorite'])

// ── Utilidad interna ──────────────────────────────────────────────
function categoryEmoji(category) {
  const map = {
    'Desayunos':          '🌅',
    'Almuerzos':          '🍛',
    'Cenas':              '🌙',
    'Sin Horno':          '🔥',
    'Postres':            '🧁',
    'Bebidas':            '🥤',
    'Ensaladas':          '🥗',
    'Platos Principales': '🍽️',
    'Comida Típica':      '🇨🇴',
  }
  return map[category] || '🍴'
}
</script>

<style scoped>
.recipe-card {
  background: var(--card-color, #EEE6FF);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: transform .2s, box-shadow .2s;
  position: relative;
}
.recipe-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 30px rgba(0, 0, 0, .1);
}

.card-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1rem .5rem;
}
.card-emoji { font-size: 2rem; }

.btn-fav {
  background: white;
  border: none;
  font-size: 1.2rem;
  border-radius: 99px;
  width: 34px;
  height: 34px;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform .15s;
}
.btn-fav:hover { transform: scale(1.15); }

.card-img  { width: 100%; height: 150px; object-fit: cover; }

.card-body {
  padding: 1rem;
  background: white;
  margin: .5rem;
  border-radius: 14px;
}
.card-category {
  font-size: .72rem;
  font-weight: 800;
  color: var(--color-primary-dark);
  text-transform: uppercase;
  letter-spacing: .5px;
}
.card-title {
  font-size: 1.05rem;
  font-weight: 800;
  color: var(--color-text);
  margin: .25rem 0 .4rem;
}
.card-desc {
  font-size: .83rem;
  color: var(--color-muted);
  line-height: 1.4;
  margin-bottom: .75rem;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.card-author { font-size: .8rem; font-weight: 700; color: var(--color-muted); }
.card-arrow  { font-weight: 800; color: var(--color-primary-dark); }
</style>