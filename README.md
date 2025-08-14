![Flutter](https://img.shields.io/badge/Flutter-3.4+-blue?logo=flutter&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-20+-green?logo=node.js&logoColor=white)
![Express](https://img.shields.io/badge/Express-4.x-black?logo=express&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

<img width="965" alt="todasjuntas" src="https://github.com/user-attachments/assets/eb9ab704-da71-4e72-be51-21284b3659c0">

# 🍔 Sistema de Lanchonete --- Flutter & Node.js

> Aplicativo de gerenciamento de pedidos e cardápio para lanchonetes,
> com **Flutter** no frontend e **Node.js + Express + MySQL** no
> backend.

------------------------------------------------------------------------

## 📋 Índice

-   [Sobre o Projeto](#-sobre-o-projeto)
-   [Tecnologias Utilizadas](#-tecnologias-utilizadas)
-   [Arquitetura](#-arquitetura)
-   [Configuração do Backend](#-configuração-do-backend)
-   [Configuração do Frontend](#-configuração-do-frontend)
-   [Rotas da API](#-rotas-da-api)
-   [Execução](#-execução)
-   [Licença](#-licença)

------------------------------------------------------------------------

## 📖 Sobre o Projeto

O sistema foi desenvolvido como projeto de estudo, permitindo que a lanchonete tenha controle
total sobre produtos, imagens e pedidos em tempo real.

Funcionalidades principais: - 📋 **Cadastro e listagem de produtos e
categorias** - 🖼 **Upload de imagens** - 🛒 **Gerenciamento de
pedidos** - 🖥 **Interface mobile profissional** - 🔄 **Comunicação em
tempo real entre frontend e backend via API REST**

------------------------------------------------------------------------

## 🚀 Tecnologias Utilizadas

### **Frontend (Flutter)**

-   Flutter 3.4+
-   Google Fonts
-   Provider (gerenciamento de estado)
-   HTTP (requisições REST)
-   MySQL1 (integração com banco)
-   Shared Preferences (armazenamento local)
-   Image Picker (upload de imagens)
-   Carousel Slider e Smooth Page Indicator
-   Flutter SVG, Ionicons, Iconsax
-   Flutter Spinkit (animações de carregamento)

### **Backend (Node.js)**

-   Node.js 20+
-   Express 4.x
-   MySQL e MySQL2 (conexão com banco)
-   Multer (upload de arquivos)
-   CORS (cross-origin)
-   Nodemon (hot reload)

------------------------------------------------------------------------

## 🏗 Arquitetura

    lanchonete/
     ├── backend/           # API REST em Node.js + Express
     │   ├── index.js       # Ponto de entrada
     │   ├── db.js          # acesso ao db
     │   ├── multerConfig.js # Config para upload de imagens
     │   ├── routes/        # Rotas da API
     │   ├── controllers/   # Lógica de cada rota
     │   ├── models/        # Conexão e consultas ao MySQL
     │   └── uploads/       # Armazenamento de imagens
     │
     ├── frontend/          # Aplicativo Flutter
     │   ├── lib/
     │   │   ├── database/  # auth e conexao
     │   │   ├── excpetions/ # tratamento de erros
     │   │   ├── models/    # entidades
     │   │   ├── pages/     # Telas (UI)
     │   │   ├── routes/    # rotas do app
     │   │   └── services/  # Comunicação com a API
     │   │   ├── utils/     # Modelos de dados
     │   │   ├── widgets/   # componetes do app
     │   └── assets/        # Imagens e ícones

------------------------------------------------------------------------

## ⚙ Configuração do Backend

### 1️⃣ Clonar repositório e instalar dependências

``` bash
git clone https://github.com/seu-usuario/lanchonete.git
cd lanchonete/backend
npm install
```

### 2️⃣ Configurar banco de dados MySQL

Crie um banco:

``` sql
CREATE DATABASE lanchonete;
```

Configurar credenciais no arquivo `.env`:

``` env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=senha
DB_NAME=lanchonete
PORT=3000
```

### 3️⃣ Rodar backend

``` bash
npm start
```

------------------------------------------------------------------------

## 📱 Configuração do Frontend (Flutter)

### 1️⃣ Acessar pasta do app

``` bash
cd lanchonete/frontend
```

### 2️⃣ Instalar dependências

``` bash
flutter pub get
```

### 3️⃣ Ajustar URL da API

No arquivo de configuração:

``` dart
const String baseUrl = "http://localhost:3000"; // ou IP local da sua máquina
```

### 4️⃣ Rodar o app

``` bash
flutter run
```

------------------------------------------------------------------------

## 🔗 Rotas da API

  Método   Endpoint          Descrição
  -------- ----------------- -------------------------
  GET      `/produtos`       Lista todos os produtos
  POST     `/produtos`       Cadastra novo produto
  PUT      `/produtos/:id`   Atualiza produto
  DELETE   `/produtos/:id`   Remove produto
  GET      `/categorias`     Lista categorias
  POST     `/categorias`     Cadastra categoria

------------------------------------------------------------------------

## ▶ Execução Completa

1.  **Inicie o backend**

    ``` bash
    cd backend && npm start
    ```

2.  **Inicie o frontend**

    ``` bash
    cd frontend && flutter run
    ```


