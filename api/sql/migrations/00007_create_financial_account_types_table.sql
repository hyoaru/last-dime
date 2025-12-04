-- +goose Up
-- +goose StatementBegin
--CREATE OR REPLACE FUNCTION set_updated_at()
CREATE TABLE financial_account_types (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(50) NOT NULL,
  created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_trigger
    WHERE tgname = 'financial_account_types_update_timestamp'
  ) THEN
    CREATE TRIGGER financial_account_types_update_timestamp
    BEFORE UPDATE ON financial_account_types
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();
  END IF;
END;
$$;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TRIGGER IF EXISTS financial_account_types_update_timestamp ON financial_account_types;
DROP TABLE IF EXISTS financial_account_types;
-- +goose StatementEnd
