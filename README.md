# 📋 Tela de Hábitos — LDDM

Aplicativo mobile desenvolvido em Flutter para gerenciamento e priorização de hábitos diários. O projeto utiliza **SQLite** para persistência de dados estruturados e **SharedPreferences** para armazenamento de preferências locais do usuário.

---

## 🚀 Funcionalidades

- **Gerenciamento de Hábitos**: Criação, edição, listagem e remoção de hábitos.
- **Reordenação e Priorização**:
  - Ações de **Priorizar** (move para o topo) e **Despriorizar** (move para o fim).
  - Algoritmo automático de **normalização da ordem** para manter a integridade numérica e evitar estouro de índices.
- **Ações com Undo**: Possibilidade de desfazer a remoção de um hábito através de notificação suspensa no topo da tela.
- **Persistência Híbrida**:
  - Dados dos hábitos salvos localmente em banco relacional.
  - Configurações e preferências simples salvas em formato chave-valor.

---

## 🛠️ Tecnologias e Pacientes Utilizados

- **[Flutter](https://flutter.dev/)** / **[Dart](https://dart.dev/)**
- **[Provider](https://pub.dev/packages/provider)** — Gerenciamento de estado otimizado (`HabitosStore`).
- **[sqflite](https://pub.dev/packages/sqflite)** — Banco de dados relacional SQLite local.
- **[shared_preferences](https://pub.dev/packages/shared_preferences)** — Armazenamento local de chave-valor.
- **[path](https://pub.dev/packages/path)** — Manipulação e resolução de caminhos de arquivos do sistema.

---

## 🗄️ Arquitetura de Dados

O projeto adota uma estratégia híbrida de persistência baseada na complexidade e estrutura dos dados:

### 1. Tabela Relacional (`SQLite`)
Utilizada para armazenar a entidade **Hábito**, pois exige uma estrutura com múltiplos atributos e ordenação dinámica:
- `id`: `INTEGER PRIMARY KEY AUTOINCREMENT`
- `nome`: `TEXT`
- `meta`: `TEXT`
- `icone_code`: `INTEGER`
- `descricao`: `TEXT`
- `ordem`: `INT` (usado para ordenação via `ORDER BY ordem ASC, id ASC`)

### 2. Chave-Valor (`SharedPreferences`)
Utilizada para armazenar **preferências do usuário** e estados simples da aplicação (como o tema do app), onde a estrutura de tabela relacional seria desnecessária.

---

## 📂 Estrutura de Pastas

```text
lib/
├── dados/
│   └── habitos_repositorio.dart  # Comunicação direta com o banco SQLite
├── dominio/
│   ├── habito.dart               # Model da entidade Hábito
│   └── habitos_store.dart        # Gerenciador de estado (Provider)
├── telas/                        # Interface do usuário (UI)
└── main.dart                     # Ponto de entrada da aplicação