import express from 'express';
import { upload } from '../multerConfig.js';
import { getUsers, addUser, updateUser, deleteUser, userLogin } from '../controllers/user.js';

const router = express.Router();

router.get('/usuarios', getUsers);
router.post('/usuarios', upload.single("imagem"), addUser);
router.put('/usuarios/:id', upload.single("imagem"), updateUser);
router.delete('/usuarios/:id', deleteUser);
router.post('/usuarios/login', userLogin);

export default router;
