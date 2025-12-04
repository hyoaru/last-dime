-- +goose Up
-- +goose StatementBegin
--CREATE OR REPLACE FUNCTION set_updated_at()
CREATE TABLE transaction_classifications (
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
    WHERE tgname = 'transaction_classifications_update_timestamp'
  ) THEN
    CREATE TRIGGER transaction_classifications_update_timestamp
    BEFORE UPDATE ON transaction_classifications
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();
  END IF;
END;
$$;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TRIGGER IF EXISTS transaction_classifications_update_timestamp ON transaction_classifications;
DROP TABLE IF EXISTS transaction_classifications;
-- +goose StatementEnd
