import { db } from '../db.js';

// Função para adicionar um produto
export const createProduct = (req, res) => {
    try {
        const query = 'INSERT INTO produtos (`nome`, `descricao`, `descricao_longa`, `valor`, `categoria`, `imagem`, `nome_url`, `combo`, `vendas`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
        const values = [
            req.body.nome,
            req.body.descricao,
            req.body.descricao_longa,
            req.body.valor,
            req.body.categoria,
            req.file ? req.file.filename : null, // A imagem será salva como o nome do arquivo carregado
            req.body.nome_url,
            req.body.combo,
            req.body.vendas
        ];
        db.query(query, values, (err) => {
            if (err) return res.json(err);
            return res.status(200).json('Produto adicionado com sucesso!');
        });
    } catch (error) {
        return res.json('Erro ao adicionar produto: ' + error);
    }
}

// Função para obter todos os produtos
export const getProducts = (_, res) => {
    const query = 'SELECT * FROM produtos';

    db.query(query, (err, data) => {
        if(err) return res.json(err);

        return res.status(200).json(data);    
    });
};

// Função para atualizar um produto
export const updateProduct = (req, res) => {
    try {
        const query = "UPDATE produtos SET `nome` = ?, `descricao` = ?, `descricao_longa` = ?, `valor` = ?, `categoria` = ?, `imagem` = ?, `nome_url` = ?, `combo` = ?, `vendas` = ? WHERE id = ?";
        const values = [req.body.nome, req.body.descricao, req.body.descricao_longa, req.body.valor, req.body.categoria, req.file ? req.file.filename : null, req.body.nome_url, req.body.combo, req.body.vendas];
        db.query(query, [...values, req.params.id], (err) => {
            if (err) return res.json(err);
            return res.status(200).json("Produto atualizado com sucesso!");
        });
    } catch (error) {
        return res.json('Erro ao atualizar produto: ' + error);
    }
}

// Função para deletar um produto
export const deleteProduct = (req, res) => {
    const query = 'DELETE FROM produtos WHERE id = ?';
    db.query(query, req.params.id, (err) => {
        if(err) return res.json(err);

        return res.status(200).json('Produto deletado com sucesso!');
    });
}

// Função para pesquisar um produto
export const searchProducts = (req, res) => {
    const query = 'SELECT * FROM produtos WHERE nome = ?';
    db.query(query, req.params.nome, (err, data) => {
        if(err) return res.json(err);

        return res.status(200).json(data);
    });
}
