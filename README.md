# 🚀 Desafio de Automação de API com Karate DSL - Accenture Academia 2026

Este repositório contém a solução do desafio técnico de automação para a **API BookStore** (DemoQA), utilizando o framework **Karate DSL**. O projeto foi estruturado para demonstrar competências em testes de integração, geração de dados dinâmicos e gerenciamento de estados de API.

## 📋 Sobre o Desafio
O objetivo principal foi automatizar os fluxos de gerenciamento de usuários e catálogo de livros, garantindo a integridade dos dados através de um ciclo de vida completo (Criação, Consulta, Atualização e Exclusão), sem a utilização de dados fixos (*hardcoded*).

### 🛠️ Tecnologias Utilizadas
* **Karate DSL**: Framework principal para testes de API BDD.
* **Java 21**: Utilizado para lógica de suporte e geração de massa.
* **Maven**: Gerenciador de dependências e execução do projeto.
* **DataFaker (v2.5.2)**: Geração dinâmica de usuários e senhas válidas.
* **JUnit 5**: Runner para execução paralela e geração de relatórios.

---

## 🏗️ Estrutura do Projeto
A organização das pastas segue as melhores práticas de modularização:

```text
src/test/java
├── features
│   ├── account                # Gerenciamento de Usuários
│   │   ├── DadosTesteUsuario  # Payloads JSON e Configuração de Usuário
│   │   │   ├── cadastrar-usuário-dado-validos.json 
│   │   │   └── usuario-config.feature  # Setup de User
│   │   ├── testes-completo-usuario-sucesso.feature
│   │   └── testes-completo-usuario-negativo.feature
│   ├── bookStore              # Gerenciamento de Livros
│   │   ├── DadosTesteLivros   # Configurações centralizadas para BookStore
│   │   │   └── usuario-livro-config.feature  # Setup de User, Token e ISBN
│   │   ├── teste-completo-livros-sucesso.feature
│   │   └── teste-completo-livros-negativo.feature
├── utils                      # Helper Java (DateGenerator.java)
├── karate-config.js           # Configurações globais de ambiente
└── KaraterTest.java           # Runner JUnit para execução paralela

````
## 🎯 Cobertura Técnica e Diferenciais

### ✅ Lógica de Setup Inteligente
O projeto utiliza um arquivo de configuração centralizado (`usuario-livro-config.feature`) que realiza o provisionamento automático para cada teste:

* **Geração Dinâmica**: Cria credenciais únicas e aleatórias através da classe `DateGenerator.java`.
* **Autenticação**: Realiza o registro do usuário e a geração do token JWT (Bearer) em tempo real para os headers das requisições.
* **Massa de Dados**: Realiza uma consulta ao catálogo (`GET /Books`) e sorteia um ISBN válido aleatoriamente para garantir a consistência das operações de manipulação de livros.

### 🚀 Funcionalidades Automatizadas
* **Account**: Cobertura completa dos endpoints `/Authorized`, `/User` (Criação e Perfil) e `/GenerateToken`.
* **BookStore**:
    * `GET /Books`: Listagem e identificação dinâmica de exemplares disponíveis.
    * `POST /Books`: Adição de livros à coleção do usuário de forma dinâmica.
    * **[Diferencial]** `GET /Book`: Implementação de busca detalhada de um livro específico por ISBN.
    * `PUT /Books/{ISBN}`: Substituição dinâmica de livros na coleção, mantendo a integridade do acervo do usuário.
    * `DELETE /Book`: Remoção individual de exemplares e funcionalidade de limpeza total (Bulk Delete) da coleção.

### 🛠️ Diferenciais de Implementação
* **Scenario Outline**: Utilização de tabelas de exemplos para validação em massa de cenários negativos (senhas inválidas, falta de autorização, IDs malformados) em uma única estrutura de teste.
* **Zero Hardcoding**: A integração total com a biblioteca **DataFaker** garante que nenhum identificador (usuário ou senha) seja fixo, permitindo execuções infinitas sem colisões de dados.
* **Gerenciamento de Estado**: Uso estratégico do comando `callonce` para otimizar o tempo de execução, criando usuários e tokens apenas quando necessário.
* **Limpeza Automática (Teardown)**: Todos os fluxos de sucesso são encerrados com a exclusão dos dados criados, mantendo o ambiente da API sempre limpo.

---

## 🚀 Como Executar

### 1. Clonar Repositório
```bash
git clone https://github.com/Tiago2lucas/Desafio_Karater_Automacao_Academia_Accenture_2026.git
````

### 🚀 2. Executar via Maven
Navegue até a pasta raiz do projeto via terminal e execute o comando abaixo para rodar todos os testes e gerar os relatórios:

```bash
mvn  test
````

### 🎯 3. Tags Principais (Execução Filtrada)
Caso deseje executar fluxos específicos do desafio, utilize as tags configuradas para isolar os cenários:

* @FluxoCompletoBookStorePositivo: Valida o ciclo de vida completo dos livros (Listar catálogo, Adicionar à coleção, Consultar por ISBN, Atualizar registro e Remover da coleção).

* @FluxoCompletoAccountPositivo: Valida o ciclo de vida completo do usuário (Autorização de credenciais, Consulta de detalhes do Perfil e Exclusão definitiva da conta).

* @FluxoCompletoBookStoreNegativo: Executa uma bateria abrangente de testes de falha e exceção utilizando Scenario Outline para validar múltiplas entradas inválidas em uma única estrutura.
  
* @FluxoCompletoAccountNegativo: Valida falhas críticas de conta via Scenario Outline, incluindo: Criação de usuário com senhas inválidas (curtas), Geração de token e autorização sem envio de senha,
 Acesso ao perfil sem token de autorização.

### 📊 Relatórios de Execução
 O Karate DSL gera relatórios HTML detalhados que contêm todas as evidências de Request (requisição) e Response (resposta), facilitando a auditoria técnica e a análise dos fluxos testados.
 Após a execução do comando "mvn test", o relatório consolidado pode ser encontrado no seguinte caminho:
 
📂 target/karate-reports/karate-summary.html

