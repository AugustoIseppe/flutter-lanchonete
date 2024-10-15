import { db } from '../db.js';

export const getUsers = (_, res) => {
    const query = 'SELECT * FROM usuarios';

    db.query(query, (err, data) => {
        if (err) return res.json(err);

        return res.status(200).json(data);
    });
};

export const addUser = (req, res) => {
    try {
        const query = "INSERT INTO usuarios (`nome`, `cpf`, `telefone`, `usuario`, `senha`, `nivel`, `imagem`) VALUES (?, ?, ?, ?, ?, ?, ?)";
        const values = [req.body.nome, req.body.cpf, req.body.telefone, req.body.usuario, req.body.senha, req.body.nivel, req.file ? req.file.filename : null,];
        db.query(query, values, (err) => {
            if (err) return res.json(err);
            return res.status(201).json("Usuário adicionado com sucesso!");
        });
    } catch (error) {
        return res.json('Erro ao adicionar usuário: ' + error);
    }
}

export const updateUser = (req, res) => {
    try {
        const query = "UPDATE usuarios SET `nome` = ?, `cpf` = ?, `telefone` = ?, `usuario` = ?, `senha` = ?, `nivel` = ?, `imagem` = ? WHERE id = ?";
        const values = [req.body.nome, req.body.cpf, req.body.telefone, req.body.usuario, req.body.senha, req.body.nivel, req.file ? req.file.filename : null, req.params.id];
        db.query(query, [...values, req.params.id], (err) => {
            if (err) return res.json(err);
            return res.status(200).json("Usuário atualizado com sucesso!");
        });
    } catch (error) {
        return res.json('Erro ao atualizar usuário: ' + error);
    }
}

export const deleteUser = (req, res) => {
    try {
        const query = "DELETE FROM usuarios WHERE `id` = ?";
        db.query(query, req.params.id, (err) => {
            if (err) return res.json(err);
            return res.status(200).json("Usuário deletado com sucesso!");
        });
    } catch (error) {
        return res.json('Erro ao deletar usuário: ' + error);
    }
}

export const userLogin = (req, res) => {
    try {
        const query = "SELECT * FROM usuarios WHERE `usuario` = ? AND `senha` = ?";
        db.query(query, [req.body.usuario, req.body.senha], (err, data) => {
            if (err) return res.json(err);
            if (data.length === 0) return res.status(401).json("Usuário ou senha inválidos!");

            return res.status(200).json(data);
        });
    } catch (error) {
        return res.json('Erro ao logar usuário: ' + error);
    }
}
