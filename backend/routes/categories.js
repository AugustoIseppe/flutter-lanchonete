import express from 'express';
import { upload } from '../multerConfig.js';
import { getCategories, createCategory, deleteCategory, updateCategory } from '../controllers/category.js';

const router = express.Router();

router.get('/categorias', getCategories); //ok
router.post('/categorias', upload.single("imagem"), createCategory); //ok
router.delete('/categorias/:id', deleteCategory); //ok
router.put('/categorias/:id', upload.single("imagem"), updateCategory); //ok
//CRUD COMPLETO - OK
export default router;