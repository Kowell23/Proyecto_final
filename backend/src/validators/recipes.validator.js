import { z } from 'zod'

export const recipeSchema = z.object({
  title: z
    .string({ required_error: 'El título es obligatorio' })
    .min(3, 'El título debe tener al menos 3 caracteres')
    .max(200),

  description: z
    .string()
    .max(500)
    .optional(),

  instructions: z
    .string({ required_error: 'Las instrucciones son obligatorias' })
    .min(10, 'Las instrucciones deben tener al menos 10 caracteres'),

  image_url: z
    .string()
    .url('La URL de la imagen no es válida')
    .optional()
    .or(z.literal('')),

  category: z
    .string()
    .max(100)
    .optional(),

  // Array de ingredientes con su cantidad
  ingredients: z
    .array(z.object({
      name:     z.string().min(1, 'El nombre del ingrediente es obligatorio'),
      quantity: z.string().optional()
    }))
    .optional()
})