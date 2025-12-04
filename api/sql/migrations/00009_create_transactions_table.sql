-- +goose Up
-- +goose StatementBegin
--CREATE OR REPLACE FUNCTION set_updated_at()
CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  transaction_type_id UUID REFERENCES transaction_types(id) ON DELETE SET NULL,
  financial_account_id UUID REFERENCES financial_accounts(id) ON DELETE SET NULL,
  transaction_category_id UUID REFERENCES transaction_categories(id) ON DELETE SET NULL,
  description VARCHAR(100) NOT NULL,
  amount NUMERIC(18, 2) NOT NULL DEFAULT 0,
  note VARCHAR(255),
  created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_trigger
    WHERE tgname = 'transactions_update_timestamp'
  ) THEN
    CREATE TRIGGER transactions_update_timestamp
    BEFORE UPDATE ON transactions
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();
  END IF;
END;
$$;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TRIGGER IF EXISTS transactions_update_timestamp ON transactions;
DROP TABLE IF EXISTS transactions;
-- +goose StatementEnd
