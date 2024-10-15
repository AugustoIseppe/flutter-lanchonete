import express from 'express'; // Importação do express
import usersRouter from './routes/users.js'; // Importação das rotas de usuários
import productsRouter from './routes/products.js'; // Importação das rotas de produtos
import categoriesRouter from './routes/categories.js'; // Importação das rotas de categorias
import cors from 'cors'; // Importação do CORS: Cross-Origin Resource Sharing -> Permite que um site acesse recursos de outro site mesmo estando em domínios diferentes
import multer from 'multer'; // Importação do multer: Middleware para upload de arquivos
import { storage } from './multerConfig.js'; // Importação da configuração do multer

const upload = multer({ storage: storage }); // Configuração do multer para salvar as imagens no diretório uploads
const app = express(); // Inicialização do express
const port = 8800; // Porta do servidor

app.use(express.json()); // Habilita o uso de JSON
app.use(cors()); // Habilita o CORS

app.use('/', usersRouter); // Utilização das rotas de usuários
app.use('/', productsRouter); // Utilização das rotas de produtos
app.use('/', categoriesRouter); // Utilização das rotas de categorias
app.use('/produtos/uploads', express.static('uploads')); // Rota para acessar as imagens dos produtos -> Necessário apenas se houver upload de imagens para os produtos
app.use('/usuarios/uploads', express.static('uploads')); // Rota para acessar as imagens dos usuários -> Necessário apenas se houver upload de imagens para os usuários
app.use('/categorias/uploads', express.static('uploads')); // Rota para acessar as imagens das categorias -> Necessário apenas se houver upload de imagens para as categorias

// app.post('/uploads', upload.single("file"), (req, res) => {
//     if (!req.file) {
//         return res.status(400).json({ message: "Arquivo não enviado" });
//     }
//     return res.json({ filename: req.file.filename });
// });

app.listen(port, () => {
    console.log('Server is running on http://localhost:8800');
});
