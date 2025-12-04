-- +goose Up
-- +goose StatementBegin
--CREATE OR REPLACE FUNCTION set_updated_at()
CREATE TABLE financial_accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  financial_account_type_id UUID REFERENCES financial_account_types(id) ON DELETE SET NULL,
  name VARCHAR(50) NOT NULL,
  balance NUMERIC(18, 2) NOT NULL DEFAULT 0,
  created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_trigger
    WHERE tgname = 'financial_accounts_update_timestamp'
  ) THEN
    CREATE TRIGGER financial_accounts_update_timestamp
    BEFORE UPDATE ON financial_accounts
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();
  END IF;
END;
$$;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TRIGGER IF EXISTS financial_accounts_update_timestamp ON financial_accounts;
DROP TABLE IF EXISTS financial_accounts;
-- +goose StatementEnd
