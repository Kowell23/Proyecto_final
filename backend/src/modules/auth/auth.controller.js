import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import pool from "../../config/db.js";

export const register = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const [existing] = await pool.query(
      "SELECT id FROM users WHERE email = ?",
      [email]
    );

    if (existing.length > 0) {
      return res.status(400).json({
        message: "El correo ya existe",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await pool.query(
      `
      INSERT INTO users (name, email, password_hash)
      VALUES (?, ?, ?)
      `,
      [name, email, hashedPassword]
    );

    console.log("🟢 Usuario registrado:", email);

    res.status(201).json({
      message: "Usuario registrado correctamente",
      userId: result.insertId,
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      message: "Error registrando usuario",
    });
  }
};

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const [users] = await pool.query(
      "SELECT * FROM users WHERE email = ?",
      [email]
    );

    if (users.length === 0) {
      console.log("🔴 Usuario no encontrado:", email);

      return res.status(401).json({
        message: "Credenciales inválidas",
      });
    }

    const user = users[0];

    const validPassword = await bcrypt.compare(
      password,
      user.password_hash
    );

    if (!validPassword) {
      console.log("🔴 Contraseña incorrecta:", email);

      return res.status(401).json({
        message: "Credenciales inválidas",
      });
    }

    const token = jwt.sign(
      {
        id: user.id,
        role: user.role,
      },
      process.env.JWT_SECRET,
      {
        expiresIn: process.env.JWT_EXPIRES_IN
      }
    );

    console.log("🟢 Usuario inició sesión:", user.email);

    res.json({
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      },
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      message: "Error iniciando sesión",
    });
  }
};