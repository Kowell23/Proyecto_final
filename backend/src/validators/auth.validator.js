import { z } from 'zod'
export const registerSchema = z.object({
  name: z
    .string({ required_error: 'El nombre es obligatorio' })
    .min(2, 'El nombre debe tener al menos 2 caracteres')
    .max(100, 'El nombre no puede superar 100 caracteres'),

  email: z
    .string({ required_error: 'El email es obligatorio' })
    .email('Formato de email inválido')
    .max(150),

  password: z
    .string({ required_error: 'La contraseña es obligatoria' })
    .min(6, 'La contraseña debe tener al menos 6 caracteres')
    .max(100)
})

export const loginSchema = z.object({
  email: z
    .string({ required_error: 'El email es obligatorio' })
    .email('Formato de email inválido'),

  password: z
    .string({ required_error: 'La contraseña es obligatoria' })
    .min(1, 'La contraseña es obligatoria')
})
