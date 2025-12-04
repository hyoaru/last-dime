# Core Application Schema

This document defines the relational structure of the financial tracking application, including all tables, primary keys (PK), foreign keys (FK), and data types.

## I. User & Account Management

| Table Name | Description | Key Columns |
| :--- | :--- | :--- |
| **[users]** | Stores user authentication and profile data. | id (PK) |
| **[financial_account_types]** | Defines static types of accounts (e.g., Wallet, E-Wallet, Savings). | id (PK) |
| **[financial_accounts]** | Stores user-specific accounts. | id (PK), financial_account_type_id (FK), user_id (FK) |

## II. Transaction Categorization Hierarchy

This structure is normalized to allow for flexible classification of expenses, while keeping classification optional (nullable) for income.

| Table Name | Description | Key Columns |
| :--- | :--- | :--- |
| **[transaction_types]** | Top-level financial grouping (Income, Expense). | id (PK) |
| **[transaction_classification]** | Defines optional grouping (Essential, Lifestyle, Transfer).id (PK) |
| **[transaction_categories]** | Stores the specific category names (e.g., Rent, Salary, Shopping). The central source for transactions. | id (PK), transaction_type_id (FK), transaction_classification_id (FK, NULLABLE) |

## III. Transaction Logging

| Table Name | Description | Key Columns |
| :--- | :--- | :--- |
| **[transactions]** | The ledger storing all financial events. | id (PK), user_id (FK), transaction_type_id (FK), financial_account_id (FK), transaction_category_id (FK) |

---

## Detailed Schema Definition

```mermaid
erDiagram

    users {
        uuid id
        string first_name
        string last_name
        string username
        string email
        datetime created_at
        datetime updated_at
    }

    financial_account_types {
        uuid id
        string name
        datetime created_at
        datetime updated_at
    }

    financial_accounts {
        uuid id
        uuid user_id
        uuid financial_account_type_id
        string name
        float balance
        datetime created_at
        datetime updated_at
    }

    transaction_types {
        uuid id
        string name
        datetime created_at
        datetime updated_at
    }

    transaction_classification {
        uuid id
        string name
        datetime created_at
        datetime updated_at
    }

    transaction_categories {
        uuid id
        uuid transaction_type_id
        uuid transaction_classification_id
        string name
        datetime created_at
        datetime updated_at
    }

    transactions {
        uuid id
        uuid user_id
        uuid transaction_type_id
        uuid financial_account_id
        uuid transaction_category_id
        string description
        float amount
        string note
        datetime created_at
        datetime updated_at
    }

    %% Relationships
    users ||--o{ financial_accounts : "has many"
    financial_account_types ||--o{ financial_accounts : "type of"

    users ||--o{ transactions : "has many"
    financial_accounts ||--o{ transactions : "used in"

    transaction_types ||--o{ transaction_categories : "categorized by"
    transaction_classification ||--o{ transaction_categories : "classified by"

    transaction_types ||--o{ transactions : "type of"
    transaction_categories ||--o{ transactions : "category of"
```
