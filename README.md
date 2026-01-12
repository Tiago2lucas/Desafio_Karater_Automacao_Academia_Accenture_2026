# 🚀 Desafio de Automação de API com Karate DSL - Accenture Academia 2026
Este repositório contém a solução do desafio técnico de automação para a API BookStore (DemoQA), utilizando o framework Karate DSL. O projeto foi estruturado para demonstrar competências em testes de integração, geração de dados dinâmicos e gerenciamento de estados de API.

## 📋 Sobre o Desafio
O objetivo principal : 
Criar uma suíte de testes automatizados para a API BookStore usando Karate DSL, cobrindo endpoints Account (para gerar token) e BookStore (GET, POST, DELETE, PUT), com cenários de sucesso e falha.

## 🛠️ Tecnologias Utilizadas
### Karate DSL: Framework principal para testes de API BDD.

* Java 21: Utilizado para lógica de suporte e geração de massa.

* Maven: Gerenciador de dependências e execução do projeto.

* DataFaker (v2.5.2): Geração dinâmica de usuários e senhas válidas.

* JUnit 5: Runner para execução paralela e geração de relatórios.

## 💻 Configuração do Ambiente de Desenvolvimento
Para garantir que o projeto execute corretamente e que você tenha suporte total à sintaxe do Karate, siga as recomendações abaixo:

Pré-requisitos
* JDK 21: Certifique-se de que a variável JAVA_HOME aponta para o Java 21 ou superior.

* Maven 3.x: Necessário para gerenciar dependências e rodar via terminal.

### Configuração da IDE
Visual Studio Code (VS Code)
* Instale as seguintes extensões para suporte completo:

* Karate (oficial da Karate Labs): Fornece realce de sintaxe e botões de Run/Debug diretamente nos arquivos .feature.

* Cucumber (Gherkin) Full Support: Auxilia no preenchimento automático (autocomplete).

* Extension Pack for Java: Essencial para a integração do VS Code com o Maven e o Java 21.

IntelliJ IDEA
* Instale os seguintes plugins via Marketplace:

* Karate: Plugin oficial para suporte e execução dos cenários.

* Gherkin: Para reconhecimento da sintaxe de arquivos de funcionalidade.

* Cucumber for Java: Recomendado para melhor formatação de código.

## 🏗️ Estrutura do Projeto
A organização das pastas segue as melhores práticas de modularização:

```
src/test/java
├── features
│   ├── account                # Gerenciamento de Usuários
│   │   ├── DadosTesteUsuario  # Payloads JSON e Configuração de Usuário
│   │   │   ├── cadastrar-usuário-dado-validos.json 
│   │   │   └── usuario-config.feature  # Setup de User
│   │   ├── testes-completo-usuario-sucesso.feature
│   │   └── testes-completo-usuario-negativo.feature
│   ├── bookStore              # Gerenciamento de Livros
│   │   ├── DadosTesteLivros   # Configurações centralizadas para BookStore
│   │   │   └── usuario-livro-config.feature  # Setup de User, Token e ISBN
│   │   ├── teste-completo-livros-sucesso.feature
│   │   └── teste-completo-livros-negativo.feature
├── utils                      # Helper Java (DateGenerator.java)
├── karate-config.js           # Configurações globais de ambiente
└── KarateTest.java            # Runner JUnit para execução paralela
```

## 🎯 Cobertura Técnica e Diferenciais
✅ Lógica de Setup Inteligente
O projeto utiliza um arquivo de configuração centralizado (usuario-livro-config.feature) que realiza o provisionamento automático para cada teste:

* Geração Dinâmica: Cria credenciais únicas e aleatórias através da classe DateGenerator.java.

* Autenticação: Realiza o registro do usuário e a geração do token JWT (Bearer) em tempo real para os headers das requisições.

* Massa de Dados: Realiza uma consulta ao catálogo (GET /Books) e sorteia um ISBN válido aleatoriamente para garantir a consistência das operações de manipulação de livros.

## 🚀 Funcionalidades Automatizadas
Account: Cobertura completa dos endpoints /Authorized, /User (Criação e Perfil) e /GenerateToken.

BookStore:

* GET /Books: Listagem e identificação dinâmica de exemplares disponíveis.

* POST /Books: Adição de livros à coleção do usuário de forma dinâmica.

* GET /Book: Implementação de busca detalhada de um livro específico por ISBN.

* PUT /Books/{ISBN}: Substituição dinâmica de livros na coleção, mantendo a integridade do acervo do usuário.

* DELETE /Book: Remoção individual de exemplares e funcionalidade de limpeza total (Bulk Delete) da coleção.

## 🛠️ Diferenciais de Implementação
### Scenario Outline: Utilização de tabelas de exemplos para validação em massa de cenários negativos (senhas inválidas, falta de autorização, IDs malformados) em uma única estrutura de teste.

* Zero Hardcoding: A integração total com a biblioteca DataFaker garante que nenhum identificador (usuário ou senha) seja fixo, permitindo execuções infinitas sem colisões de dados.

* Gerenciamento de Estado: Uso estratégico do comando callonce para otimizar o tempo de execução, criando usuários e tokens apenas quando necessário.

* Limpeza Automática (Teardown): Todos os fluxos de sucesso são encerrados com a exclusão dos dados criados, mantendo o ambiente da API sempre limpo.

### 🚀 Como Executar
1. Clonar Repositório
````
git clone https://github.com/Tiago2lucas/Desafio_Karater_Automacao_Academia_Accenture_2026.git
````
### 🚀 2. Executar via Maven
Navegue até a pasta raiz do projeto via terminal e execute o comando abaixo para rodar todos os testes e gerar os relatórios:
```
mvn test
```

## 🎯 3. Tags Principais (Execução Filtrada)
Caso deseje executar fluxos específicos do desafio, utilize as tags configuradas para isolar os cenários:

* @FluxoCompletoBookStorePositivo: Valida o ciclo de vida completo dos livros.

* @FluxoCompletoAccountPositivo: Valida o ciclo de vida completo do usuário.

* @FluxoCompletoBookStoreNegativo: Bateria abrangente de testes de falha em livros via Scenario Outline.

* @FluxoCompletoAccountNegativo: Valida falhas críticas de conta (senhas curtas, falta de token, etc).

## 📊 Relatórios de Execução
O Karate DSL gera relatórios HTML detalhados com todas as evidências de Request e Response. Após a execução, o relatório pode ser encontrado em:

📂 target/karate-reports/karate-summary.html
