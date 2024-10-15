import { db } from '../db.js';

// Função para buscar todas as categorias
export const getCategories = (_, res) => {
    const query = 'SELECT * FROM categorias';

    db.query(query, (err, data) => {
        if(err) return res.json(err);

        return res.status(200).json(data);    
    });
};

// Função para adicionar uma categoria
export const createCategory = (req, res) => {
    try {
        const query = "INSERT INTO categorias (`nome`, `descricao`, `imagem`, `nome_url`, `produtos`) VALUES (?, ?, ?, ?, ?)";
        const values = [req.body.nome, req.body.descricao, req.file ? req.file.filename : null, req.body.nome_url, req.body.produtos];
        
        db.query(query, values, (err) => {
            if (err) {
                console.error("Erro ao criar categoria Lindinho:", err); // Log para depuração
                return res.status(500).json({ error: 'Erro ao criar categoria lindinho', details: err });
            }
            return res.status(201).json({ message: 'Categoria criada com sucesso lindinho!' });
        });
    } catch (error) {
        console.error("Erro ao processar requisição:", error); // Log para depuração
        return res.status(500).json({ error: 'Erro ao processar requisição', details: error });
    }
}


// Função para deletar uma categoria
export const deleteCategory = (req, res) => {
    try {
        const query = "DELETE FROM categorias WHERE `id` = ?";
        db.query(query, req.params.id, (err) => {
            if (err) return res.json(err);
            return res.status(200).json("Categoria deletada com sucesso!");
        });
    } catch (error) {
        return res.json('Erro ao deletar categoria: ' + error);
    }
}

// Função para atualizar uma categoria
export const updateCategory = (req, res) => {
    try {
        const query = "UPDATE categorias SET `nome` = ?, `descricao` = ?, `imagem` = ?, `nome_url` = ?, `produtos` = ? WHERE id = ?";
        const values = [req.body.nome, req.body.descricao, req.file ? req.file.filename : null, req.body.nome_url, req.body.produtos, req.params.id];
        db.query(query, [...values, req.params.id], (err) => {
            if (err) return res.json(err);
            return res.status(200).json("Categoria atualizada com sucesso!");
        });
    } catch (error) {
        return res.json('Erro ao atualizar categoria: ' + error);
    }
}
//req.file ? req.file.filename : null
