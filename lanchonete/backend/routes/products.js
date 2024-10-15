import express from 'express';
import { upload } from '../multerConfig.js';
import { getProducts, searchProducts, updateProduct, deleteProduct, createProduct} from '../controllers/product.js';

const router = express.Router();

router.get('/produtos', getProducts);
router.get('/produtos/:nome', searchProducts);
router.put('/produtos/:id', upload.single("imagem"), updateProduct);
router.delete('/produtos/:id', deleteProduct);
router.post('/produtos', upload.single("imagem") , createProduct);

export default router;