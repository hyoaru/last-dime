-- +goose Up
-- +goose StatementBegin
--CREATE OR REPLACE FUNCTION set_updated_at()
CREATE TABLE transaction_categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  transaction_type_id UUID REFERENCES transaction_types(id) ON DELETE SET NULL,
  transaction_classification_id UUID REFERENCES transaction_classifications(id) ON DELETE SET NULL,
  name VARCHAR(50) NOT NULL,
  created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_trigger
    WHERE tgname = 'transaction_categories_update_timestamp'
  ) THEN
    CREATE TRIGGER transaction_categories_update_timestamp
    BEFORE UPDATE ON transaction_categories
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();
  END IF;
END;
$$;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TRIGGER IF EXISTS transaction_categories_update_timestamp ON transaction_categories;
DROP TABLE IF EXISTS transaction_categories;
-- +goose StatementEnd
